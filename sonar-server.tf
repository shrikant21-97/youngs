resource "aws_instance" "sonar-server"{
    ami = data.aws.ami.lastest.id
    instance_type = "t3.medium"
    user_data = file("./sonar.server.sh")
    tags = {
        Name = "sonar-server"
    }   
    key_name = ("my-key-pair")
     

security_groups = [aws_security_group.our-security_group.sonar.id]
 root_block_device {
   volume_size = 20


  }
}