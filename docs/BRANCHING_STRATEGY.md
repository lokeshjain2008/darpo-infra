# Branching Strategy

## Overview

This repository follows a trunk-based development strategy with environment branches for infrastructure management.

## Branch Types

### Main Branches

- `main` - Production environment infrastructure
- `develop` - Development environment infrastructure

### Feature Branches

Format: `feature/<ticket-number>-short-description`
Example: `feature/INFRA-123-add-redis-cluster`

### Bug Fix Branches

Format: `fix/<ticket-number>-short-description`
Example: `fix/INFRA-456-fix-rds-backup`

### Documentation Branches

Format: `docs/<short-description>`
Example: `docs/update-deployment-guide`

### Infrastructure Module Branches

Format: `module/<module-name>-<action>`
Example: `module/eks-monitoring-setup`

## Branch Flow

1. **Production Changes**
   ```
   feature/... -> develop -> main
   ```

2. **Hotfixes**
   ```
   fix/... -> main
   ```

3. **Documentation**
   ```
   docs/... -> main
   ```

## Protected Branches

- `main` (Production)
  - Requires pull request approval
  - Requires passing CI checks
  - No direct pushes
  - Auto-deploys to production

- `develop` (Development)
  - Requires pull request approval
  - Requires passing CI checks
  - Auto-deploys to development

## Working with Branches

1. **Creating a New Feature**
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/INFRA-123-add-redis-cluster
   ```

2. **Creating a Hotfix**
   ```bash
   git checkout main
   git pull origin main
   git checkout -b fix/INFRA-456-fix-rds-backup
   ```

3. **Merging Changes**
   ```bash
   # For features
   git checkout develop
   git merge --no-ff feature/INFRA-123-add-redis-cluster

   # For hotfixes
   git checkout main
   git merge --no-ff fix/INFRA-456-fix-rds-backup
   ```

## Best Practices

1. **Commit Messages**
   - Use conventional commits format
   - Include ticket number if applicable
   - Be descriptive but concise

2. **Branch Lifecycle**
   - Delete feature branches after merging
   - Keep branches up to date with their base
   - Regularly clean up old branches

3. **Code Review**
   - All changes must go through PR review
   - Use PR templates
   - Include relevant tests and documentation

4. **Infrastructure Changes**
   - Include Terraform plan output in PRs
   - Document any manual steps required
   - Update relevant documentation

## CI/CD Integration

Each branch type triggers different CI/CD workflows:

- `feature/*`: Runs validation and plan
- `develop`: Deploys to development environment
- `main`: Deploys to production environment
- `fix/*`: Runs validation and plan