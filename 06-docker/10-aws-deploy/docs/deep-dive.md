# Smart Lead on AWS: deep dive

Back to the [summary](../README.md).

## The business problem

The Smart Lead API turns customer messages into sales leads, but it only ran on a developer's machine. The business needed it reachable over HTTPS around the clock, secure (private data, no credentials in code), rebuildable from code, safe to change through reviewed pipelines, and reliable.

## What I built, step by step

By hand first to understand each service, then in Terraform one layer at a time, verifying each before the next.

0. **Foundations:** a private, versioned state bucket, a domain with a Route 53 zone, and the GitHub OIDC role ([`bootstrap/`](../bootstrap/)).
1. **Network** ([`network.tf`](../terraform/network.tf), [`security_groups.tf`](../terraform/security_groups.tf)): a VPC with three subnet tiers over two AZs, internet and NAT gateways, and security groups chained load balancer → app → database. The database tier has no internet route.
2. **Data** ([`database.tf`](../terraform/database.tf), [`messaging.tf`](../terraform/messaging.tf), [`secrets.tf`](../terraform/secrets.tf)): RDS PostgreSQL with enforced TLS, SQS with a dead-letter queue, and a generated password in Secrets Manager.
3. **Compute** ([`compute.tf`](../terraform/compute.tf), [`iam.tf`](../terraform/iam.tf), [`ecr.tf`](../terraform/ecr.tf)): an ECR registry, a least-privilege IAM role, and a launch template that runs Docker Compose. An Auto Scaling group in the private subnets replaces instances one at a time on release.
4. **Edge** ([`edge.tf`](../terraform/edge.tf), [`waf.tf`](../terraform/waf.tf)): a load balancer checking `/actuator/health`, an ACM certificate, HTTP→HTTPS redirect, DNS alias, and a WAF with managed rules and a rate limit.
5. **Delivery:** two GitHub Actions workflows.

Access is by Session Manager: no SSH, no key pair.

## How to run and test it

Image build: see my [journey log](../../../my-journey/progress.md#building-the-app-image) (section 09, Capstone: Smart Lead).

The app can be run in two different ways. They test different things.

### 1. Locally (anyone with Docker)

Clone the repo and build the image on your own machine. The app then runs **only on that machine**, at `localhost`. Nobody else can reach it and there is no HTTPS or domain. This proves the image and its dependencies work.

```bash
git clone https://github.com/jrrugge/devops-exercises1.git
cd devops-exercises1/06-docker/09-capstone-smart-lead
cp env.example .env
docker compose up -d --build        # app + PostgreSQL + local SQS

export APP=http://localhost:8080
curl -i $APP/actuator/health        # expect 200, "status":"UP", db UP
curl -i -X POST $APP/api/v1/messages -H 'Content-Type: application/json' \
  -d '{"content":"How much does the pro plan cost?"}'   # expect 2xx
curl $APP/api/v1/leads              # the qualified lead

docker compose down
```

### 2. In AWS (needs an AWS account and a domain)

To test the real thing (HTTPS on a domain, behind the load balancer and WAF), the image has to be **deployed first**. The environment is destroyed between sessions to control cost, so the live URL only works while it is up.

```bash
# 1. One-time: state bucket, DNS zone (name servers set at the registrar), OIDC role
cd 06-docker/10-aws-deploy/bootstrap && terraform init && terraform apply

# 2. Create the image registry first
cd ../terraform && terraform init
terraform apply -target=aws_ecr_repository.app

# 3. Push the image to it: the pipeline does this on merge, or by hand
aws ecr get-login-password | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
cd ../../09-capstone-smart-lead
docker build --platform linux/amd64 -t <account-id>.dkr.ecr.us-east-1.amazonaws.com/smartlead-app:<tag> .
docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/smartlead-app:<tag>

# 4. Set app_image_tag, zone_name and app_domain in terraform.tfvars, then build everything
cd ../10-aws-deploy/terraform && terraform apply
```

If the image is not in the registry before the apply, the instances start with no application. Once it finishes (about 10 minutes), test against the real domain with the same commands:

```bash
export APP=https://smartlead.cloudenglabs.dev    # or your own app_domain
curl -i $APP/actuator/health        # expect 200, db UP, over HTTPS
```

Tear it down when finished (one expected error: the registry still holds images):

```bash
terraform destroy
```

## CI/CD pipeline

- [`terraform.yml`](../../../.github/workflows/terraform.yml): runs on pull requests that change the Terraform code: format, validate and plan. Apply is manual, from `main` only.
- [`app.yml`](../../../.github/workflows/app.yml): runs when the app code changes: builds the image on pull requests, and on merge pushes it to ECR tagged with the commit hash. Docs-only changes do not trigger it.
- **Release:** change the image tag in `terraform.tfvars`, so every version is a revertible commit.

**Security built in:** OIDC instead of stored keys, the role bound to this repo by immutable IDs; minimal workflow permissions; a state lock; no secrets in the repo; a private encrypted state bucket; scanned, commit-tagged images. Fork pull requests get no cloud token.

## Trade-offs

| Choice | Why | Production alternative |
| --- | --- | --- |
| One NAT, single-AZ database | Cost | One per AZ, Multi-AZ RDS |
| Docker Compose on EC2 | Mirrors local running | ECS on Fargate |
| Admin-level pipeline role | Speed in a lab | Scoped roles |
| One environment | Cost, and one I could fully explain | Dev, staging, prod |

## Challenges and how I solved them

| Challenge | Cause and lesson |
| --- | --- |
| OIDC login failed | The token subject includes numeric IDs my policy lacked. Printed the claims and compared |
| Load balancer `503`, healthy app | Nothing in the target group: an unsaved file. Check real AWS state |
| New instances had no app | `destroy` deleted the registry. It now survives teardowns |
| CI would fail on `mvnw` | Windows loses the execute bit. Test what your laptop hides |

## What I would do next for production grade readiness

1. **ECS on Fargate** instead of EC2 and Compose: serverless containers with no hosts to patch, scaling with demand, failures replaced automatically. Data, network, secrets and WAF carry over.
2. **Dev, staging and prod:** build once and promote the same image through separate accounts, with per-environment tfvars and state, a GitHub Environment per stage (prod trusting only `environment:prod`), tests gating staging and approval before prod.
3. **Harden the pipeline** (the admin role is the biggest gap): split plan and apply roles, branch protection, code owners, actions pinned to hashes, scanning gates, image signing.
4. Tests in CI, blue/green releases, alarms, multi-AZ.
