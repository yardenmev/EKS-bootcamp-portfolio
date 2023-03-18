
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  # version = "19.10.0"
  # version = "18.29.0"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.25"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size = 50
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 3
      min_size     = 3
      max_size     = 3

      labels = {
        role = "general"
      }

      instance_types = var.EKS_instance_types
      capacity_type  = "ON_DEMAND"
    }
  }

}