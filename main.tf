provider "aws" {
  region = var.provider_region
  default_tags {
    tags = {
      Owner           = "yarden"
      expiration_date = "30-02-23"
      bootcamp        = "int"
    }
  }
}
terraform {
  backend "s3"{
    bucket = "yarden-s3"
    key = "EKS-tf"
    region = "eu-west-1"
  }
}
