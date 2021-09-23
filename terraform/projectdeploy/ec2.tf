provider "aws" {
    region = "us-east-1"
}

resource "aws_spot_instance_request" "cheap_worker" {
    count           = length(var.components)
    ami             = "ami-074df373d6bafa625"
    instance_type   = "t3.micro"
    spot_price      = "0.0032"

    tags {
        Name    = element(var.components,count.index)
    }
}