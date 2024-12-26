#!/bin/bash

# Get environment from argument
ENV=$1

# Apply database migration job
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migration
  namespace: darpo-${ENV}
spec:
  ttlSecondsAfterFinished: 100
  template:
    spec:
      containers:
      - name: migration
        image: ${ECR_REGISTRY}/darpo-app:${IMAGE_TAG}
        command: ["npx", "prisma", "migrate", "deploy"]
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: DATABASE_URL
      restartPolicy: Never
  backoffLimit: 3
EOF

# Wait for migration to complete
kubectl wait --for=condition=complete job/db-migration -n darpo-${ENV} --timeout=300s
