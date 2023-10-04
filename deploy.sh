#!/bin/bash

for ((dir=2; dir <= $#; dir++));do
          echo "Deploying Terraform configurations in $dir"
          cd "$dir"
          echo "terraform init -backend-config=$1/backend.tfvars"
          terraform init -backend-config=$1/backend.tfvars
          terraform validate
          echo "terraform plan -var-file=$1/$1.tfvars -out=tfplan"
          terraform plan -var-file=$1/$1.tfvars -out=tfplan
          cd -
          done
