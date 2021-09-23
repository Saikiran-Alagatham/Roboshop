resource "aws_security_group" "allow_ssh"{
    name            = "allow_ssh"
    description     = "allow_ssh"

    ingress {
        description     = "allow_ssh" 
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

output "sg_id"{
    value  = aws_security_group.allow_ssh.id
}