variable "ami_name" {
  type = string
  default = "ami-0360c520857e3138f"
}

variable "instance_type" {
  type = list(string)
  default = ["t3.small", "t3.micro"]
}

variable "az" {
  type = string
  default = "us-east-1a"
}

variable "key_name" {
  type = string
  default = "vnc"
}

variable "vol_size" {
  type = number
  default = 20
}

variable "vol_type" {
  type = string
  default = "gp3"
}