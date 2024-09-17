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
