variable "project" {}
variable "vpc_id" {}

variable "http_access_cidr" {
  default = "0.0.0.0/0"
}

variable "ssh_allowed_ip" {
  description = "Your IP for SSH"
  type        = list(string)
}
