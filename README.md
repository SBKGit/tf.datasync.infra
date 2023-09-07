## About The Project

This project helps to deploy datasync task and datasync agent creation using terraform.

<div align="left">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/terraform/terraform-original.svg" height="40" alt="terraform logo"  />
</div>

### Prerequisites
- awscli 
- terraform latest version

### How to deploy

NOTE :- Deploy in same order as listed

1. Deploy VPC_baston
2. Deploy VPC_Datasync  
3. Deploy VPC_Lambda
- configure awscli with access key and secret key
```sh
aws configure 
```
- Navigate to VPC_baston to deploy baston server and VPC1
```sh
cd VPC_baston
```
- Initialize terraform 
```sh
terraform init 
```
- terraform plan to check what are we going to deploy
```sh
terraform plan --var-file=variables/<env>.fvars
```
- Apply changes to aws account.
```sh
terraform apply --var-file=variables/<env>.fvars
```
- Terraform will prompt for approval type Yes

- repeat the same for other 2 folders 

### NOTE :- Please deploy in same order as listed



