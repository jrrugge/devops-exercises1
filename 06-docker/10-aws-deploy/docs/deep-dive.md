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

Image build: see my [journey log](../../../my-journey/progress.md#building-the-app-image). under Ref: 07 - Capstone: Full-Stack App on Docker

```bash
cd 06-docker/09-capstone-smart-lead
docker compose up -d --build

export APP=http://localhost:8080     
curl -i $APP                          # expect 200, db UP
curl -i -X POST $APP/api/v1/messages -H 'Content-Type: application/json' \
  -d '{"content":"How much does the pro plan cost?"}'   # expect 2xx
curl $APP/api/v1/leads               # the qualified lead
```

AWS (needs Terraform 1.10+):

```bash
cd bootstrap && terraform init && terraform apply
cd ../terraform && terraform init
terraform apply -target=aws_ecr_repository.app   # registry first, push image
terraform apply
terraform destroy   # one expected error: registry holds images
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

## What I would do next

1. **ECS on Fargate** instead of EC2 and Compose: serverless containers with no hosts to patch, scaling with demand, failures replaced automatically. Data, network, secrets and WAF carry over.
2. **Dev, staging and prod:** build once and promote the same image through separate accounts, with per-environment tfvars and state, a GitHub Environment per stage (prod trusting only `environment:prod`), tests gating staging and approval before prod.
3. **Harden the pipeline** (the admin role is the biggest gap): split plan and apply roles, branch protection, code owners, actions pinned to hashes, scanning gates, image signing.
4. Tests in CI, blue/green releases, alarms, multi-AZ.

