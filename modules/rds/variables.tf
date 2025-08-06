variable "project" {}
variable "instance_type" {
  default = "db.t3.micro"
}
variable "db_subnet_ids" {
  type = list(string)
}
variable "db_sg_id" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
