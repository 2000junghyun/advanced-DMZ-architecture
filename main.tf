# VPC & Network
module "vpc" {
  source = "./modules/vpc"

  project             = var.project
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs

  dmz_subnet_cidrs    = var.dmz_subnet_cidrs
  web_subnet_cidrs    = var.web_subnet_cidrs
  app_subnet_cidrs    = var.app_subnet_cidrs
  db_subnet_cidrs     = var.db_subnet_cidrs
}

provider "aws" {
  region = var.aws_region
}

# Security groups
module "security_group" {
  source           = "./modules/security_group"
  project          = var.project
  vpc_id           = module.vpc.vpc_id
  http_access_cidr = var.http_access_cidr
  ssh_allowed_ip   = var.ssh_allowed_ip
}

# ALB
module "alb" {
  source         = "./modules/alb"
  project        = var.project
  vpc_id         = module.vpc.vpc_id
  dmz_subnet_ids = module.vpc.dmz_subnet_ids
  sg_alb_id      = module.security_group.alb_sg_id
}

# WAF
module "waf" {
  source       = "./modules/waf"
  name         = "dmz-secure-waf"
  description  = "WAF for ALB"
  region       = var.aws_region
  resource_arn = module.alb.alb_arn
}

# Bastion
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

module "bastion_host" {
  source           = "./modules/bastion"
  project          = var.project
  ami_id           = data.aws_ami.ubuntu.id
  instance_type    = var.instance_type
  key_pair_name    = var.key_pair_name
  sg_bastion_id    = module.security_group.bastion_sg_id
  dmz_subnet_id    = module.vpc.dmz_subnet_ids[0] # 하나만 선택
  user_data_file   = var.bastion_user_data
}

# Web tier EC2
module "ec2_web" {
  source = "./modules/ec2_web"
  project               = var.project
  ami_id                = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  key_pair_name         = var.key_pair_name
  user_data_path        = var.web_user_data
  web_sg_id             = module.security_group.web_sg_id
  web_target_group_arn  = module.alb.target_group_arn
  web_subnet_ids        = module.vpc.web_subnet_ids
}

# App tier EC2
module "ec2_app" {
  source              = "./modules/ec2_app"
  project             = var.project
  ami_id              = data.aws_ami.ubuntu.id
  instance_type       = var.instance_type
  key_pair_name       = var.key_pair_name
  user_data_path      = var.app_user_data
  app_sg_id           = module.security_group.app_sg_id
  app_subnet_ids      = module.vpc.app_subnet_ids
}

# DB tier
module "rds" {
  source              = "./modules/rds"
  project             = var.project
  instance_type       = var.db_instance_type
  db_subnet_ids       = module.vpc.db_subnet_ids
  db_sg_id            = module.security_group.db_sg_id
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
}