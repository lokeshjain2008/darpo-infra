## Description

Please include a summary of the changes and the related issue. Please also include relevant motivation and context.

Ticket: [INFRA-XXX](ticket-link)

## Type of change

Please delete options that are not relevant.

- [ ] Infrastructure Change (AWS, EKS, RDS, etc.)
- [ ] Configuration Update (Kubernetes manifests, environment variables)
- [ ] Documentation Update
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)

## Impact and Dependencies

- **Impact Assessment:**
  - Service disruption: Yes/No
  - Data migration required: Yes/No
  - Cost impact: Increase/Decrease/None

- **Dependencies:**
  - Requires database changes: Yes/No
  - Requires secrets update: Yes/No
  - Requires config changes: Yes/No

## Terraform Plan

```hcl
# If this PR includes infrastructure changes, paste the Terraform plan output here
```

## Checklist:

- [ ] I have performed a self-review of my code/changes
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] I have run `terraform plan` and reviewed the output
- [ ] I have tested the changes in a development environment

## Testing Instructions

1. Step-by-step instructions to test these changes
2. Any specific configurations needed
3. Expected results

## Rollback Plan

Describe how to rollback these changes if needed:

1. Rollback steps
2. Required commands
3. Verification steps

## Additional Notes

Add any additional notes or screenshots here.