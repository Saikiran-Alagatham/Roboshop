provider "aws" {
    region      = "us-east-1a"
}


resource "aws_instance" "singleServer"{
    ami            = "ami-074df373d6bafa625"
    instance_type  = "t2.micro"

    tag     = {
        name    = "roboshopSingle"
    }
}

resource "aws_security_group" "allow_ssh_single_server"{
    name        = "allow_ssh_single_server"
    description = "allow_ssh_single_server"
    vpc_id      = 

    ingrees     = [
        {
            description     = "SSH"
            from_port       = 22
            to_port         = 22
            protocol        = "tcp"
             cidr_blocks      = ["0.0.0.0/0]


        }
    ]

    engress     =[
        {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0]
        }
    ]
}