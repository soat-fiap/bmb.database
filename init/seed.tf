data "aws_security_group" "default_sg" {
  name   = "default"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "mysql_ingress" {
  type              = "ingress"
  security_group_id = data.aws_security_group.default_sg.id
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "ingress rule used to seed mysql database from pipeline"
}

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
      version = "~>5.64.0"
    }
  }
  required_version = "~>1.9.4"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"

  secret_key = var.aws_secret_key
  access_key = var.aws_access_key

  default_tags {
    tags = {
      Terraform = "true"
      "teste"   = "teste"
    }
  }
}
