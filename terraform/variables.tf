# VPC
variable "subnet_cidr" {
  type = string
}

variable "subnet_az" {
  type = string
}

# EC2
variable "instance_type" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}