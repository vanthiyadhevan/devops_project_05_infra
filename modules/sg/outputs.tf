# output "jenkins_id" {
#   value = aws_security_group.jenkins_sg.id
# }
# output "docker_id" {
#   value = aws_security_group.docker_sg.id
# }

output "sg_ids" {
  value = [
    aws_security_group.jenkins_sg.id,
    aws_security_group.docker_sg.id,
  ]
}