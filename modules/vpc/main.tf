terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

resource "aws_vpc" "ci_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "ci_igw" {
  vpc_id = aws_vpc.ci_vpc.id

  tags = {
    Name = var.igw_name
  }

  depends_on = [aws_vpc.ci_vpc]
}

resource "aws_subnet" "ci_pub_sub" {
  vpc_id                  = aws_vpc.ci_vpc.id
  cidr_block              = var.pub_sub_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = var.pub_sub_name
  }

  depends_on = [aws_vpc.ci_vpc]
}

resource "aws_route_table" "ci_pub_sub_rt" {
  vpc_id = aws_vpc.ci_vpc.id

  route {
    cidr_block = var.all_traffic_bound
    gateway_id = aws_internet_gateway.ci_igw.id
  }

  tags = {
    Name = var.pub_sub_rt_name
  }
}

resource "aws_route_table_association" "ci_pub_sub_rt_associ" {
  subnet_id      = aws_subnet.ci_pub_sub.id
  route_table_id = aws_route_table.ci_pub_sub_rt.id

  depends_on = [
    aws_vpc.ci_vpc,
    aws_subnet.ci_pub_sub,
    aws_route_table.ci_pub_sub_rt
  ]
}