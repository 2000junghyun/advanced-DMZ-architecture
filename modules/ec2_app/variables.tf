variable "project" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_pair_name" {}
variable "user_data_path" {}
variable "app_sg_id" {}

variable "app_subnet_ids" {
  description = "List of Private Subnet IDs for App EC2"
  type        = list(string)
}
