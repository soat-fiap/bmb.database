
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }

  filter {
    name   = "tag:Terraform"
    values = ["true"]
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Terraform"
    values = ["true"]
  }

  filter {
    name   = "tag:kubernetes.io/role/internal-elb"
    values = ["1"]
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Terraform"
    values = ["true"]
  }

  filter {
    name   = "tag:kubernetes.io/role/elb"
    values = ["1"]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(concat(data.aws_subnets.private_subnets.ids))
  id       = each.value
}

module "aurora_db_serverless_cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 9.9.0"

  name              = var.cluster_name
  database_name     = var.database_name
  engine            = "aurora-mysql"
  engine_mode       = "serverless"
  storage_encrypted = true


  instances = {
    dev = {}
  }

  master_username             = var.username
  master_password             = var.password
  manage_master_user_password = false

  autoscaling_enabled  = false
  vpc_id               = data.aws_vpc.vpc.id
  db_subnet_group_name = var.vpc_name
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = [for s in data.aws_subnet.subnet : s.cidr_block]
    }
  }

  publicly_accessible = true
  apply_immediately   = true
  # enabled_cloudwatch_logs_exports = ["general"]
  enable_http_endpoint = true
  monitoring_interval  = 0
  skip_final_snapshot  = true

  serverlessv2_scaling_configuration = {
    min_capacity = 1
    max_capacity = 2
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
