#!/bin/bash

# Create IAM policy for EKS cluster management
cat << EOF > eks-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*",
                "ec2:*",
                "rds:*",
                "elasticache:*",
                "iam:*",
                "ecr:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF

# Create the policy
aws iam create-policy \
    --policy-name DarpoInfraPolicy \
    --policy-document file://eks-policy.json

# Create IAM user for infrastructure management
aws iam create-user --user-name darpo-infra

# Attach policy to user
aws iam attach-user-policy \
    --user-name darpo-infra \
    --policy-arn arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/DarpoInfraPolicy

# Create access key for the user
aws iam create-access-key --user-name darpo-infra
