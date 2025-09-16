output "vpc_id" {
  value = aws_vpc.ci_vpc.id
}

output "subnet_id" {
  value = aws_subnet.ci_pub_sub.id
}

output "igw_id" {
  value = aws_internet_gateway.ci_igw.id
}