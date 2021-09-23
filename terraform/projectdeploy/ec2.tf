

resource "aws_spot_instance_request" "cheap_worker" {
    count                   = length(var.components)
    ami                     = "ami-074df373d6bafa625"
    instance_type           = "t3.micro"
    spot_price              = "0.0032"
    wait_for_fulfillment    = true

    tags {
        Name    = element(var.components,count.index)
    }
}

resource "aws_security_group" "allow_ssh" {
    name            =   "allow_ssh"
    description     =   "allow_ssh"

    ingress{
        description     = "allow_ssh"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_port       = ["0.0.0.0/0"]
    }

    egress{
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_port       = ["0.0.0.0/0"]
    }
}