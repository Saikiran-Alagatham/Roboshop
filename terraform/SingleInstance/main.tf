module "sg"{
    source      = "./sg"
}

module "ec2"{
    source      = "./ec2"
    sg_id       = module.sg.sg_id
}


provider "aws"{
    region = "us-east-1"
}


terraform{
    backend "s3"{
        bucket  = "roboshop-s3"
        key     = "roboshop/terraform.tfstate"
        region  = "us-east-1"
        dynamodb_table = "terraform"
    }
}

