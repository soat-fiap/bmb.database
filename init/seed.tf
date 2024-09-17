resource "random_string" "random_suffix" {
  length  = 5
  special = false
  upper   = true
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "rds-db-secret-${random_string.random_suffix.result}"
  description = "RDS database credentials"

  tags = {
    Terraform = "true"
  }
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username            = var.username,
    password            = var.password,
    engine              = var.engine,
    host                = var.host,
    port                = var.port,
    dbClusterIdentifier = var.dbClusterIdentifier,
  })
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.67.0"
    }
  }
  required_version = "~>1.9.4"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"

  default_tags {
    tags = {
      Terraform = "true"
      "teste"   = "teste"
    }
  }
}
