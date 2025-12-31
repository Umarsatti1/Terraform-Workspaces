# Terraform Workspaces

## Overview
This project demonstrates the use of **Terraform Workspaces** to manage multiple environments (**dev, staging, prod**) using a single Terraform codebase. Each workspace maintains an isolated Terraform state while reusing the same infrastructure definitions.

The infrastructure is deployed on **AWS** and includes a VPC, subnet, routing components, security groups, and EC2 instances using **Terraform modules**.

---

## Key Concepts Covered
- Terraform workspaces and state isolation
- Workspace-based environment management
- Workspace-specific variables using `.tfvars`
- Modular Terraform design
- Multi-environment AWS infrastructure
- Resource tagging using `terraform.workspace`
- Infrastructure lifecycle management (apply, destroy, cleanup)

---

## Environments
The following environments are managed using Terraform workspaces:
- **dev**
- **staging**
- **prod**

Each workspace provisions:
- A dedicated VPC
- Public subnet
- Internet Gateway
- Route table
- Security group
- EC2 instance with environment-specific sizing

---

## Project Structure
```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── dev.tfvars
├── staging.tfvars
├── prod.tfvars
├── modules/
│   ├── vpc/
│   └── ec2/
└── README.md
```

---

## Prerequisites
- Terraform >= 1.12.0
- AWS CLI configured with valid credentials

---

## Initialize Terraform
```bash
terraform init
```

---

## Workspace Management

### Create Workspaces
```bash
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
```

### List Workspaces
```bash
terraform workspace list
```

### Switch Workspace
```bash
terraform workspace select dev
```

---

## Deploy Infrastructure
Select the workspace and apply the corresponding variable file:

### For **dev** workspace
```bash
terraform workspace select dev
terraform apply -auto-approve -var-file="dev.tfvars"
```

### For **staging** workspace
```bash
terraform workspace select staging
terraform apply -auto-approve -var-file="staging.tfvars"
```

### For **prod** workspace
```bash
terraform workspace select prod
terraform apply -auto-approve -var-file="prod.tfvars"
```

---

## Workspace-Based Behavior
- Environment names are derived from `terraform.workspace`
- Resource names and tags include the active workspace
- Instance types, subnet CIDRs, AZs, and storage differ per environment
- Each workspace maintains an independent state file

---

## Validate Deployment
- Verify resources in the AWS Management Console
- Access EC2 public IPs to confirm environment-specific Apache web pages
- Confirm tagging reflects the correct workspace

---

## Destroy Infrastructure
Terraform destroy must be run per workspace:
```bash
terraform workspace select dev
terraform destroy -auto-approve -var-file="dev.tfvars"
```

### For **staging** workspace
```bash
terraform workspace select staging
terraform destroy -auto-approve -var-file="staging.tfvars"
```

### For **prod** workspace
```bash
terraform workspace select prod
terraform destroy -auto-approve -var-file="prod.tfvars"
```

---

## Delete Workspaces
After destroying all resources:
```bash
terraform workspace select default
terraform workspace delete dev
terraform workspace delete staging
terraform workspace delete prod
```

> **Note:** A workspace must not be active when deleting it.

---

## Conclusion
This project demonstrates how Terraform workspaces enable clean, scalable, and isolated multi-environment infrastructure management using a single codebase. By combining workspaces with modules and environment-specific variables, infrastructure can be safely deployed, validated, and destroyed across multiple environments.

---

## References
- https://developer.hashicorp.com/terraform/cli/workspaces
- https://developer.hashicorp.com/terraform/language/backend/s3
- https://spacelift.io/blog/terraform-workspaces
- https://dev.to/aws-builders/terraform-workspaces-and-multi-environment-deployments-12gb
- https://medium.com/@b0ld8/terraform-manage-multiple-environments-63939f41c454#f409
- https://medium.com/@surangajayalath299/what-is-terraform-backend-how-used-it-ea5b36f08396

