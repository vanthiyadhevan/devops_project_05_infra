output "vpc_id" {
  value = module.vpc.vpc_id
}
output "subnet_id" {
  value = module.vpc.subnet_id
}

output "sg_ids" {
  value = module.security_group.sg_ids
}