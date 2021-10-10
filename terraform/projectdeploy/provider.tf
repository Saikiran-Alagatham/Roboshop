terraform{
    backend "s3"{
        bucket  = "roboshopbucket"
        key     = "roboshopbucket/projectdeploy/terraform.tfstate"
        region  = "us-east-1"
        dynamodb_table = "terraform1"
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}



provider "aws" {
    region = "us-east-1"
}