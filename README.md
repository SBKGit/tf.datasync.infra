## About The Project

This project helps to deploy datasync task and datasync agent creation using terraform.

<div align="left">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/terraform/terraform-original.svg" height="40" alt="terraform logo"  />
</div>

### Prerequisites
- awscli 
- terraform latest version

### How to deploy

- configure awscli with access key and secret key
```sh
aws configure 
```
- cd to root folder eg., VPC_Datasync
- run following command to copy backend.tf to root folder
```sh
cp  <env name>/backend.tf .  
```
- Initialize terraform 
```sh
terraform init 
```
- terraform plan to check what are we going to deploy
```sh
terraform plan -var-file=<env name>.tfvars  
```
- Apply changes to aws account.
```sh
terraform apply -var-file=<env name>.tfvars  
```
- Terraform will prompt for approval type Yes




