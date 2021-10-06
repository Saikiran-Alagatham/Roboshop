terraform{
    # backend "s3"{
    #     # bucket  = "roboshop-s3"
    #     # key     = "roboshop/projectdeploy/terraform.tfstate"
    #     # region  = "us-east-1"
    #     # dynamodb_table = "terraform"
    # }
}



provider "aws" {
    region = "us-east-1"
}