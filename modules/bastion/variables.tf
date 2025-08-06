variable "project" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_pair_name" {}
variable "sg_bastion_id" {}
variable "dmz_subnet_id" {
  description = "Single public subnet (from dmz_subnet_ids)"
  type        = string
}
variable "user_data_file" {
  description = "Provisioning script for bastion host"
  type        = string
}
