resource "aws_instance" "jenkins_server" {
  ami                         = var.ami_name
  instance_type               = var.instance_type[0]
  availability_zone           = var.az
  associate_public_ip_address = true

  key_name = var.key_name
  #   disable_api_stop = true
  #   disable_api_termination = true
  root_block_device {
    volume_size = var.vol_size
    volume_type = var.vol_type
  }
  vpc_security_group_ids = [var.sg_ids[0]]
  subnet_id              = var.subnet_id

  user_data_base64 = filebase64("${path.module}/jenkins_automation.sh")

  tags = {
    Name = var.instance_name[0]
  }
}

resource "aws_instance" "docker_server" {
  ami                         = var.ami_name
  instance_type               = var.instance_type[1]
  availability_zone           = var.az
  associate_public_ip_address = true
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_ids[1]]
  # subnet_id                   = path.module.vpc.aws_subnet.ci_pub_sub.id
  # vpc_security_group_ids      = [path.module.sg.aws_security_group.docker_sg.id]


  #   disable_api_stop = true
  #   disable_api_termination = true

  root_block_device {
    volume_size = var.vol_size
    volume_type = var.vol_type
  }

  user_data_base64 = filebase64("${path.module}/docker_automation.sh")

  tags = {
    Name = var.instance_name[1]
  }
}