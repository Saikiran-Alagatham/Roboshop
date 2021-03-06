resource "aws_spot_instance_request" "cheap_worker" {
    count                   = length(var.components)
    ami                     = "ami-074df373d6bafa625"
    instance_type           = "t2.micro"
    vpc_security_group_ids = "sg-04371d9790f1294b1"
    wait_for_fulfillment    = true

    tags = {
        Name    = element(var.components,count.index)
    }
}

resource "aws_ec2_tag" "name-tag"{
    count                   = length(var.components)
    resource_id             = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index)
    key                     = "Name"
    value                   = element(var.components,count.index)
}


resource "aws_route53_records" "routing" {
    name                = element(var.components,count.index)
    type                = "A"
    zone_id             = "Z07887073609GNEKE5JLH"
    ttl                 = 300
    records             = [element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)]    
  
}


resource "null_resource" "running_shell_scripting" {
    count                   = length(var.components)

    provisioner "remote-exec" {
        
        connection {
            host                = element(aws_spot_instance_request.cheap_worker.*.public_ip, count.index)
            username            = "centos"
            password            = "DevOps321"

        } 

        inline  = [
            "cd /home/centos",
            "git clone https://DevOps-Batches@dev.azure.com/DevOps-Batches/DevOps57/_git/shell_scripting",
            "cd shell_scripting/roboshop",
            "sudo make ${element(var.components,count.index)}"

        ]

    }
  
}
