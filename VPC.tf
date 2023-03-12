module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr

  azs                 = var.azs
  private_subnets     = var.private_subnets
  public_subnet_tags  = var.public_subnet_tags
  public_subnets      = var.public_subnets
  private_subnet_tags = var.private_subnet_tags


  enable_nat_gateway = true
  single_nat_gateway = true


}