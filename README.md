# Darpo Infrastructure

This repository contains the infrastructure as code (IaC) for the Darpo multi-tenant application.

## Overview

This infrastructure supports a multi-tenant NestJS application with:
- Amazon EKS for container orchestration
- Amazon RDS (PostgreSQL) for database
- Amazon ElastiCache for caching
- VPC with public and private subnets
- Auto-scaling configuration
- Monitoring and logging setup

## Prerequisites

### Required Tools
- AWS CLI v2
- Terraform >= 1.0
- kubectl
- helm v3
- Docker

### AWS Account Setup

1. Create an AWS Account
2. Create an IAM user with necessary permissions:
   ```bash
   ./scripts/setup-aws-permissions.sh
   ```
3. Configure AWS CLI:
   ```bash
   aws configure
   ```

## Repository Structure

```
darpo-infra/
├── terraform/                 # Infrastructure as Code
│   ├── modules/              # Reusable Terraform modules
│   │   ├── eks/             # EKS cluster configuration
│   │   ├── rds/             # RDS database setup
│   │   ├── vpc/             # Network configuration
│   │   └── redis/           # ElastiCache setup
│   ├── environments/         # Environment-specific configs
│   │   ├── dev/
│   │   └── prod/
│   └── variables.tf
├── kubernetes/               # Kubernetes manifests
│   ├── base/                # Base configurations
│   └── overlays/            # Environment-specific overlays
│       ├── dev/
│       └── prod/
└── scripts/                 # Utility scripts
```

## Quick Start

### Development Environment

1. Initialize Terraform:
   ```bash
   cd terraform/environments/dev
   terraform init
   ```

2. Apply Infrastructure:
   ```bash
   terraform plan -out=tfplan
   terraform apply tfplan
   ```

3. Configure kubectl:
   ```bash
   aws eks update-kubeconfig --name darpo-dev --region us-west-2
   ```

4. Deploy Kubernetes Resources:
   ```bash
   kubectl apply -k kubernetes/overlays/dev
   ```

### Production Environment

1. All production deployments should go through the CI/CD pipeline:
   ```bash
   git checkout main
   git push origin main
   ```

2. The GitHub Actions workflow will:
   - Validate Terraform configurations
   - Apply infrastructure changes
   - Update Kubernetes resources

## Infrastructure Details

### VPC Configuration
- Region: us-west-2 (configurable)
- 3 Availability Zones
- Public and Private Subnets
- NAT Gateways
- VPC Endpoints

### EKS Cluster
- Version: 1.28
- Node Groups: t3.large instances
- Auto-scaling enabled
- Cluster Autoscaler
- AWS Load Balancer Controller

### RDS Database
- Engine: PostgreSQL 15.3
- Multi-AZ deployment
- Automated backups
- Performance Insights enabled

### Security
- Network policies
- Security groups
- IAM roles and policies
- Secrets management

## Monitoring and Logging

- CloudWatch Container Insights
- CloudWatch Logs
- Prometheus & Grafana
- Fluent Bit for log aggregation

## Disaster Recovery

1. Database:
   - Automated backups
   - Point-in-time recovery
   - Cross-region replication (optional)

2. Application:
   - Kubernetes deployments are versioned
   - Infrastructure is version controlled
   - State files are backed up

## Cost Optimization

- Dev environment uses smaller instances
- Prod environment uses auto-scaling
- Spot instances for non-critical workloads
- Regular cost monitoring and optimization

## Contributing

1. Clone the repository
2. Create a feature branch
3. Submit a pull request

## Support

For issues:
1. Create a GitHub issue
2. Contact DevOps team
3. Check AWS documentation

## License

MIT License