variable "project" {}
variable "instance_type" {}
variable "key_pair_name" {}
variable "user_data_path" {}
variable "web_sg_id" {}
variable "web_target_group_arn" {}

variable "web_subnet_ids" {
  description = "Web Subnet IDs for Web EC2"
  type = list(string)
}

variable "ami_id" {
  description = "AMI ID for Web EC2"
  type        = string
}