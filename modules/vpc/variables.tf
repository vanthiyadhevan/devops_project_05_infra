variable "vpc_cidr" {
  type    = string
  default = "11.10.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "CI-VPC"
}

variable "igw_name" {
  type    = string
  default = "CI-IGW"
}

variable "pub_sub_name" {
  type    = string
  default = "PUB-SUB"
}

variable "pub_sub_cidr" {
  type    = string
  default = "11.10.1.0/24"
}

variable "az" {
  type    = string
  default = "us-east-1a"
}

variable "all_traffic_bound" {
  type    = string
  default = "0.0.0.0/0"
}

variable "pub_sub_rt_name" {
  type    = string
  default = "PUB-SUB-RT"
}