output "jenkins_instance_id" {
  value = aws_instance.jenkins_server.id
}
output "docker_instance_id" {
  value = aws_instance.docker_server.id
}

