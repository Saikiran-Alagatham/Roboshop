provider "aws"{
    region      = "us-east-1"
}

resource "aws_instance" "singleS3" {
    ami                     = "ami-074df373d6bafa625"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.allow_ssh_single_server.id]

    tags        = {
        name    = "singleWithS3"
    }
}

resource "aws_security_group" "allow_ssh_single_server" {
    name            = "allow_ssh_single_server"
    description     = "allow_ssh_single_server"
    
    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

terraform{
    backend  "s3" {
        bucket       = "roboshop-s3"
        key          = "roboshop/terraform.tfstate"
        region       = "us-east-1"
    }
}