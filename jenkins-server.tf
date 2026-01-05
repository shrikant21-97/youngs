################################################################################################################################################################################################################################################################################################################################
# Fetching latest AMI ID of ubuntu 22.04
#################################################################################################################
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}
###########################################################################################################
# Creating EC2 instance out of this latest AMI
###########################################################################################################
resource "aws_instance" "jenkins-server"{
  ami =data.aws.ami.lastest.id
  instance_type = "t3.micro"
  key_name = "my-key-pair"
  subnet_id = aws_subnet.our-public-subnet.subnet_id
  user_data= file("/.jenkins-server.sh")
  iam_instance_profile = aws_iam_instance_profile.our-iam-instance-profile.name
  security_groups  = [aws_security_group.our-sg-jenkins-server.name]
  root_block_device {
    volume_size = 20
    tags = {
      Name = "jenkins-server"
    }

  }
}