variable "name" {
  description = "WAF Web ACL name"
  type        = string
}

variable "description" {
  description = "WAF Web ACL description"
  type        = string
  default     = "WAF for ALB"
}

variable "resource_arn" {
  description = "ARN of the ALB to associate WAF with"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
