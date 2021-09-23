
resource "aws_instance" "SingleInstance"{
    count               = 3
    ami                 = "ami-074df373d6bafa625"
    instance_type       = "t2.micro"
    vpc_security_group_ids = [var.sg_id]

    tags    = {
        Name    = "roboshopSingle-${count.index}"
    }
}


variable "sg_id" {}