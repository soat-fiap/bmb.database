################################################################################
# Database
################################################################################

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.subnet : s.cidr_block]
}

output "cluster" {
  value = module.aurora_db_serverless_cluster
  sensitive = true
}

# output "file" {
#   value = null_resource.db_setup
# }