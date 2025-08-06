variable "project" {}
variable "vpc_cidr" {}
variable "azs" {
  type = list(string)
}

variable "dmz_subnet_cidrs" {
  type = list(string)
}
variable "web_subnet_cidrs" {
  type = list(string)
}
variable "app_subnet_cidrs" {
  type = list(string)
}
variable "db_subnet_cidrs" {
  type = list(string)
}
