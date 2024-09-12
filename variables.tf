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
  default = "techchallenge-mysql-default"
}

variable "database_name" {
  type    = string
  default = "techchallenge-default"
}

variable "username" {
  type      = string
  sensitive = true
  default   = "techchallenge-default"
}

variable "password" {
  type      = string
  sensitive = true
  default   = "F#P9ia-3-default"
}

variable "environment" {
  default = "dev"
  type    = string
}
