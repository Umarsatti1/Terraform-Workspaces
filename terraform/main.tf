locals {
  env = terraform.workspace

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "${terraform.workspace}-umarsatti-vpc" # Workspace-specific name
  igw_name = "${terraform.workspace}-umarsatti-igw" # Workspace-specific name
  ami_id   = "ami-0ecb62995f68bb549"                # Unique AMI ID
  keypair  = "webapp"                               # Existing key pair
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = local.vpc_cidr
  vpc_name    = local.vpc_name
  igw_name    = local.igw_name
  subnet_cidr = var.subnet_cidr
  subnet_az   = var.subnet_az
  subnet_name = "${local.env}-public-subnet"
  rt_name     = "${local.env}-public-rt"
  sg_name     = "${local.env}-sg"
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = local.ami_id
  instance_type = var.instance_type
  keypair       = local.keypair
  volume_size   = var.volume_size
  volume_type   = var.volume_type
  instance_name = "${local.env}-ec2"
  subnet_id     = module.vpc.subnet_id
  sg_id         = module.vpc.sg_id
}