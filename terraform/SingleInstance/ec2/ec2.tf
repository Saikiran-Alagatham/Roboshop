
resource "aws_instance" "SingleInstance"{
    ami                 = "ami-074df373d6bafa625"
    instance_type       = "t2.micro"
    vpc_security_group_ids = [var.sg_id]

    tags    = {
        Name    = "roboshopSingle"
    }
}


variable "sg_id" {}