variable "jenkins_name" {
  type    = string
  default = "Jenkins-SG"
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "cidr_ipv4" {
  type    = string
  default = "0.0.0.0/0"
}
variable "cidr_ipv6" {
  type    = string
  default = "::/0"
}
variable "https" {
  type    = number
  default = 443
}
variable "http" {
  type    = number
  default = 80
}

variable "egress_protocol" {
  type    = string
  default = "-1"
}

variable "all_inter_bound" {
  type    = string
  default = "0.0.0.0/0"
}

variable "docker_name" {
  type    = string
  default = "docker-SG"
}

variable "ssh" {
  type    = number
  default = 22
}

variable "jenkins_port" {
  type    = number
  default = 8080
}

# -----------------------------
# Testing VPC 
# -----------------------------
variable "vpc_id" {
}