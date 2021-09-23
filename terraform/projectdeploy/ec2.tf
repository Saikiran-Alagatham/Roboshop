

resource "aws_spot_instance_request" "cheap_worker" {
    count                   = length(var.components)
    ami                     = "ami-074df373d6bafa625"
    instance_type           = "t3.micro"
    spot_price              = "0.0032"
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

