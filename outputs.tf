# VPC & Network
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "dmz_subnet_ids" {
  value = module.vpc.dmz_subnet_ids
}

output "web_subnet_ids" {
  value = module.vpc.web_subnet_ids
}

output "app_subnet_ids" {
  value = module.vpc.app_subnet_ids
}

output "db_subnet_ids" {
  value = module.vpc.db_subnet_ids
}

# Security groups
output "alb_sg_id" {
  value = module.security_group.alb_sg_id
}

output "bastion_sg_id" {
  value = module.security_group.bastion_sg_id
}

output "web_sg_id" {
  value = module.security_group.web_sg_id
}

output "app_sg_id" {
  value = module.security_group.app_sg_id
}

output "db_sg_id" {
  value = module.security_group.db_sg_id
}

# ALB
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

# WAF
output "waf_acl_arn" {
  value       = module.waf.waf_acl_arn
  description = "WAF ACL ARN"
}

# Bastion
output "bastion_public_ip" {
  value = module.bastion_host.bastion_public_ip
}

# Web tier
output "web_asg_name" {
  value = module.ec2_web.web_asg_name
}

# App tier
output "app_asg_name" {
  value = module.ec2_app.app_asg_name
}

# DB tier
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}