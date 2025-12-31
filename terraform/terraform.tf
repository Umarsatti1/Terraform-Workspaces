terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }

  backend "s3" {
    bucket               = "umarsatti-terraform-state-file-s3-bucket"
    key                  = "terraform.tfstate"
    region               = "us-east-1"
    encrypt              = true
    use_lockfile         = true
    workspace_key_prefix = "Workspaces"
  }
}

provider "aws" {
  region = "us-east-1"
}