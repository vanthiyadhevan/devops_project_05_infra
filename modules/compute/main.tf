terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

resource "aws_instance" "jenkins_server" {
  ami = var.ami_name
  instance_type = var.instance_type[0]
  availability_zone = var.az

  key_name = var.key_name
#   disable_api_stop = true
#   disable_api_termination = true
  root_block_device {
    volume_size = var.vol_size
    volume_type = var.vol_type
  }
  vpc_security_group_ids = [path.module.sg.aws_security_group.jenkins-SG.id]
  subnet_id = path.module.vpc.aws_subnet.ci_pub_sub.id

  user_data = filebase64("jenkins_automation.sh")
}

resource "aws_instance" "docker_server" {
  ami = var.ami_name
  instance_type = var.instance_type[1]
  availability_zone = var.az
  key_name = var.key_name
  subnet_id = path.module.vpc.aws_subnet.ci_pub_sub.id
  vpc_security_group_ids = [path.module.sg.aws_security_group.docker-SG.id]

#   disable_api_stop = true
#   disable_api_termination = true
  
  root_block_device {
    volume_size = var.vol_size
    volume_type = var.vol_type
  }

  user_data = filebase64("docker_automation.sh")
}