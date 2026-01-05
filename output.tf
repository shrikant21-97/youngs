output "vpc_id" {
  value = aws.our_vpc
}
output "Instance_id" {
  value = aws_instance.sonar-server.id
}
output "Instance_id" {
    value = aws_instance.jenkins-server.id

}
output "jenkins-ip" {
    value = aws_instance.jenkins-server.public_ip
}       
output "nexux-ip" {
    value = aws_instance.nexus-server.public_ip
}
output "sonar-ip" {
    value = aws_instance.sonar-server.public_ip
}
