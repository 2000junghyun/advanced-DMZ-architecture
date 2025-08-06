# VPC & Network
variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "dmz_subnet_cidrs" {
  description = "CIDR blocks for DMZ subnets (public)"
  type        = list(string)
}

variable "web_subnet_cidrs" {
  description = "CIDR blocks for Web tier subnets (private)"
  type        = list(string)
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for App tier subnets (private)"
  type        = list(string)
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks for DB tier subnets (private)"
  type        = list(string)
}

# Security groups
variable "ssh_allowed_ip" {
  description = "CIDR blocks allowed to access Bastion Host via SSH"
  type        = list(string)
}

variable "http_access_cidr" {
  description = "CIDR blocks allowed to access ALB via HTTP/HTTPS"
  type        = string
  default     = "0.0.0.0/0"
}

# Bastion
variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}

variable "bastion_user_data" {
  description = "Path to bastion provisioning script"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 (e.g. t3.micro)"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the existing EC2 Key Pair"
  type        = string
}

# Web tier EC2
variable "web_user_data" {
  description = "Path to setup_web.sh for Web EC2"
  type        = string
}

# App tier EC2
variable "app_user_data" {
  description = "Path to setup_app.sh for App EC2"
  type        = string
}

# DB tier RDS 사용
variable "db_instance_type" {
  default = "db.t3.micro"
}
variable "db_name" {
  default = "mydb"
}
variable "db_username" {
  default = "admin"
}
variable "db_password" {
  description = "RDS root password"
  sensitive   = true
}