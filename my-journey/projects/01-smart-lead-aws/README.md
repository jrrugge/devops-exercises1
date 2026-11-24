# DevOps and Cloud Engineering Portfolio

Hi, I'm [@jrrugge](https://github.com/jrrugge). I'm building towards a **cloud / platform engineering** role, learning by building things end to end and documenting how and why.

## Featured project: Smart Lead on AWS

A developer handed me the source code for a Spring Boot API and asked me to make it available online, hosted in AWS. I analysed the application, packaged it into a container image, designed the AWS platform and built it with Terraform and GitHub Actions.

- Private three-tier network, load balancer, managed PostgreSQL and SQS
- HTTPS on my own domain, with a web application firewall
- Infrastructure as code: 57 resources that build in about 10 minutes and destroy with one command
- CI/CD with GitHub Actions and OIDC, with no AWS keys stored anywhere

**[Read the case study](projects/01-smart-lead-aws/README.md)** · [Deep dive](projects/01-smart-lead-aws/deep-dive.md)

## Skills demonstrated

| Area | Evidence |
| --- | --- |
| AWS | VPC and subnet design, ALB, ACM, Route 53, WAF, RDS, SQS, Secrets Manager, ECR, IAM, Auto Scaling, Session Manager |
| Infrastructure as code | Terraform with remote state and locking, built and verified layer by layer |
| CI/CD and security | GitHub Actions, OIDC federation, plan on pull request, controlled apply, commit-tagged images |
| Containers | Multi-stage Docker builds, Compose, health checks, volumes, networking |
| Linux, shell and Git | Labs from the log below |

## Learning path

| | |
| --- | --- |
| **Done** | Linux, Vim, shell scripting, Git and GitHub, Docker, an end-to-end AWS deployment |
| **Next** | HashiCorp Terraform Associate (004), then Kubernetes (CKA/CKAD) |
| **Project next** | ECS on Fargate and a dev, staging and prod promotion workflow |

## Where to look

- [Smart Lead on AWS](projects/01-smart-lead-aws/README.md): the case study
- [My journey log](progress.md): every course module with screenshots and notes
- [Command cheatsheet](cheatsheet.md)
