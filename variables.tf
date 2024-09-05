variable "profile" {
  description = "AWS profile name"
  type        = string
  default     = "default"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "eks-fiap-vpc"
}

variable "cluster_name" {
  type    = string
  default = "techchallenge-mysql"
}

variable "username" {
  type      = string
  sensitive = true
  default   = "techchallenge"
}

variable "password" {
  type      = string
  sensitive = true
  default   = "F#P9ia-3"
}
