cidr               = "10.0.0.0/16"
provider_region    = "us-east-2"
EKS_instance_types = ["t3a.large"]
azs                = ["us-east-2a", "us-east-2b", "us-east-2c"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
vpc_name           = "yarden_vpc"
ECR_name           = "yarden-todo"
cluster_name       = "yarden_EKS"
public_subnet_tags = {
  "type" = "frontend"
}
private_subnet_tags = {
  "type" = "backend"
}