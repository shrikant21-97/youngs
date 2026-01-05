# VPC-CIDR BLOCK 
variable "vpc_cidr_value" {
    description = "CIDR value for vpc creation"
    type = string
    default = "10.0.0.0/16"

}
# ENVIORNMENT
variable "enviornment" {
description = "Enviornment for VPC creation"
type = string
default = "dev"
}

# SUBNET VARIABLE
variable "public-subnet-cidr-value"{
    description = "cidr for public subnet creation"
    type = string
    default = "10.0.0.0/24"


}
variable "public-subnet-cidr-value2"{
    description = "cidr for public subnet creation"
    type = string
    default = "10.0.3.0/24"

}
 variable "private-subnet-cidr-value"{
    description = "cidr for private subnet creation"
    type= string
    default = "10.0.1.0/24"
 }

 variable "private-subnet-cidr-value2"{
    description = "cidr for private subnet creation"
    type = string
    default = "10.0.2.0/16"

 }