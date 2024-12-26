# Credential Management

## Database Credentials

### Local Development

Sensitive credentials are managed using environment variables. Before running Terraform commands, set the following:

```bash
# Set database username
export TF_VAR_db_username="your_db_username"

# Run terraform commands
terraform plan
```

### CI/CD Pipeline

For GitHub Actions, set the following secrets:
- `DB_USERNAME`: Database administrator username

The workflow will use these secrets as environment variables:
```yaml
env:
  TF_VAR_db_username: ${{ secrets.DB_USERNAME }}
```

## Security Notes

1. Never commit sensitive credentials to version control
2. Use environment variables for local development
3. Use GitHub Secrets for CI/CD pipeline
4. Rotate credentials periodically
5. Use least privilege principle for database users
