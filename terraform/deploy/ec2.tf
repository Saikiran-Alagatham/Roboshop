resource "aws_instance" "cheap_worker" {
  count                     = local.LENGTH
  ami                       = "ami-074df373d6bafa625"
  instance_type             = "t3.micro"
  vpc_security_group_ids    =  ["sg-04371d9790f1294b1"]
  tags                      = {
    Name                    = element(var.COMPONENTS, count.index)
  }
}







resource "aws_route53_record" "records" {
  count                     = local.LENGTH
  name                      = element(var.COMPONENTS, count.index)
  type                      = "A"
  zone_id                   = "Z00620242Y7LFBGQOS2W8"
  ttl                       = 300
  records                   = [element(aws_instance.cheap_worker.*.private_ip, count.index)]
}



resource "null_resource" "run-shell-scripting" {
  depends_on                = [aws_route53_record.records]
  count                     = local.LENGTH
  provisioner "remote-exec" {
    connection {
      host                  = element(aws_instance.cheap_worker.*.public_ip, count.index)
      user                  = "centos"
      password              = "DevOps321"
    }

    inline = [
    "cd /home/centos",
    "rm -rf *",
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
