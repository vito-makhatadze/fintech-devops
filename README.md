# FinTech DevOps Platform

Orchestrates infrastructure and deployments for financial services across Georgia, Uzbekistan, and Turkey.

## Structure
- `terraform/`: Infrastructure as Code for AWS resources.
- `k8s-manifests/`: Kubernetes manifests for deployments.
- `argocd-apps/`: ArgoCD application definitions.
- `monitoring/`: Prometheus, Grafana, Alertmanager configs.
- `.github/workflows/`: CI/CD pipelines.
- `scripts/`: Utility scripts.
- `docs/`: Documentation.

## Microservices
- `kyc-service`: github.com/your-org/kyc-service
- `blockchain-service`: github.com/your-org/blockchain-service
- `finance-service`: github.com/your-org/finance-service

## Setup
1. Run `./setup.sh` to initialize structure.
2. Configure AWS credentials (`aws configure`).
3. Apply Terraform: `cd terraform/environments/georgia/dev && terraform init && terraform apply`.
4. Push to GitHub and configure ArgoCD.

## Branching Strategy
- `main`: Production-ready code.
- `feature/<username>/<jira-ticket>`: New features.
- `hotfix/<username>/<jira-ticket>`: Bug fixes.
- `sandbox/<feature-or-epic>`: Collaborative testing.

## Semantic Commits
Use Conventional Commits: `feat(kyc): [JIRA-123] Add deployment`.

## CI/CD
Main repo triggers ArgoCD syncs after microservice image updates.
