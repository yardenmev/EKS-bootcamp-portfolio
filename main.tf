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
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}
terraform {
  backend "s3" {
    bucket = "yarden-s3"
    key    = "EKS-tf"
    region = "eu-west-1"
  }
}
