resource "aws_instance" "cheap_worker" {
  count                     = local.LENGTH
  ami                       = "ami-074df373d6bafa625"
  instance_type             = "t3.micro"
  vpc_security_group_ids    =  [aws_security_group.allow_ssh_single_server.id]
  tags                      = {
    Name                    = element(var.COMPONENTS, count.index)
  }
}

# resource "aws_ec2_tag" "name-tag" {
#   count                     = local.LENGTH
#   resource_id               = element(aws_instance.cheap_worker.*.public_ip, count.index)
#   key                       = "Name"
#   value                     = element(var.COMPONENTS, count.index)
# }

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








resource "null_resource" "run-shell-scripting" {
  count                     = local.LENGTH
  provisioner "local-exec" {
    connection {
      user                  = "centos"
      password              = "DevOps321"
    }

    command = [
    "cd /home/centos",
    "git clone https://DevOps-Batches@dev.azure.com/DevOps-Batches/DevOps57/_git/shell-scripting",
    "cd shell-scripting/roboshop",
    "git pull",
    "sudo make ${element(var.COMPONENTS, count.index)}"
    ]
  }
}

locals {
  LENGTH    = length(var.COMPONENTS)
}
