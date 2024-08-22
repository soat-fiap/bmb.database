################################################################################
# Database
################################################################################

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.subnet : s.cidr_block]
}
output "name" {
  value = data.aws_rds_cluster.bancodedados.endpoint
}