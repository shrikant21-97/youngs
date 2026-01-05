resource "aws_vpc" "our_vpc" {
  cidr_block = "var.vpc_cidr"
  tags = {
    Name = "our-vpc"
    Enivorment = "var.environment"
  }

  
}
resource "aws_internet_gateway" "our_igw" {
  vpc_id = aws_vpc.our_vpc.id
  tags = {
    Name = "our-igw"
    Environment = "var.environment"
  }
}
resource "aws-subnet" "our-public-subnet" {
  vpc_id            = aws_vpc.our_vpc.id
  cidr_block        = "var.public_subnet_cidr"
  availability_zone = data.aws_available_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "our-public-subnet"
    Environment = "var.environment"
  }
}

resource "aws_subnet" "our-public-subnet-2" {
  vpc_id            = aws_vpc.our_vpc.id
  cidr_block        = "var.public_subnet_cidr_2"
  availability_zone = data.aws_available_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "our-public-subnet-2"
    Environment = "var.environment"
  }
}
resource "aws_private_subnet" "our_private_subnet" {
  vpc_id            = aws_vpc.our_vpc.id
  cidr_block        = "var.private_subnet_cidr"
  map_public_ip_on_launch = false
  availability_zone = data.aws_available_zones.available.names[0]
  tags = {
    Name = "our-private-subnet"
    Environment = "var.environment"
  }
}
resource "aws_private_subnet" "our_private_subnet_2" {
  vpc_id            = aws_vpc.our_vpc.id
  cidr_block        = "var.private_subnet_cidr_2"
  map_public_ip_on_launch = false
  availability_zone = data.aws_available_zones.available.names[1]
  tags = {
    Name = "our-private-subnet-2"
    Environment = "var.environment"
  }
}

resource "aws_route_table" "our-public-rt" {
  vpc_id = aws_vpc.our_vpc.id
  tags = {
    Name = "our-public-rt"
    Environment = "var.environment"
  }
}

resource "aws_route_table" "our-public-rt-2" {
  vpc_id = aws_vpc.our_vpc.id
  tags = {
    Name = "our-public-rt-2"
    Environment = "var.environment"
  }
}
resource "aws_route_table" "our-private-rt" {
  vpc_id = aws_vpc.our_vpc.id
  tags = {
    Name = "our-private-rt"
    Environment = "var.environment"
  }
}

resource "aws_route_table" "our-private-rt2"{
    vpc_id = aws_vpc.our_vpc.id
    tags = {
        Name = "our-private-rt2"
        Environment = "var.environment"
    }
}
# AWS SUBNET ROUTE TABLE ASSOCIATIONS
resource "aws_route_table_association" "our-public-subnet-assoc" {
    subnet_id      = aws_subnet.our-public-subnet.id
    route_table_id = aws_route_table.our-public-rt.id
    }
resource "aws_route_table_association" "our-public-subnet-2-assoc" {
    subnet_id      = aws_subnet.our-public-subnet-2.id
    route_table_id = aws_route_table.our-public-rt-2.id
    }
resource "aws_route_table_association" "our-private-subnet-assoc" {
    subnet_id      = aws_private_subnet.our_private_subnet.id
    route_table_id = aws_route_table.our-private-rt.id
    }       
resource "aws_route_table_association" "our-private-subnet-2-assoc" {
    subnet_id      = aws_private_subnet.our_private_subnet_2.id
    route_table_id = aws_route_table.our-private-rt2.id
    }
          
# AWS ROUTES INTO ADDITIONAL ROUTE TABLES
resource "aws_route" "our-public-route" {
    route_table_id         = aws_route_table.our-public-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.our_igw.id    
    }   
resource "aws_route" "our-public-route-2" {
    route_table_id         = aws_route_table.our-public-rt-2.id
    destination_cidr_block = "0.0.0.0/0"    
    gateway_id             = aws_internet_gateway.our_igw.id    
    }


    # AWS SECURITY GROUP
   
    resource " aws_security_group" "our_security_group" {
        name        = "our-security-group"
        description = "Allow SSH and HTTP"
        vpc_id      = aws_vpc.our_vpc.id
        tags = {
            Name = "our-security-group"
            Environment = "var.environment"
        }

        ingress {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    resource "aws_security_group" "our-security-group-for-nexus" {
        name        = "our-security-group-for-nexus"
        description = "Allow SSH and HTTP"
        vpc_id      = aws_vpc.our_vpc.id
        tags = {
            Name = "our-security-group-for-nexus"
            Environment = "var.environment"
        }

        ingress {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"] 
    }
    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {      
        from_port   = 8081
        to_port     = 8081
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "our-security_group-for-sonar" {
    name        = "our-security-group-for-sonar"
    description = "Allow SSH and HTTP"
    vpc_id      = aws_vpc.our_vpc.id
    tags = {
        Name = "our-security-group-for-sonar"
        Environment = "var.environment"
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {       
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}   
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0 /0"]
}
}   
    }
