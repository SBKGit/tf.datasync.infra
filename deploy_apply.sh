#!/bin/bash
set -e
for ((dir=2; dir <= $#; dir++));do
          echo "Deploying Terraform configurations in ${!dir}"
          cd "${!dir}"
          echo "terraform init -backend-config=$1/backend.tfvars"
          terraform init -backend-config=$1/backend.tfvars
          terraform validate
          echo "terraform apply -var-file=$1/$1.tfvars -out=tfplan"
          terraform apply -var-file=$1/$1.tfvars -out=tfplan -auto-approve
          cd -
          done
