provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.namespace
  version    = "3.4.0"
  values     = [file("${path.module}/argocd-values.yaml")]

  depends_on = [module.eks]

  set {
    name  = "server.ingress.enabled"
    value = var.ingress_enabled
  }

  set {
    name  = "server.ingress.hosts[0].host"
    value = var.ingress_host
  }

  set {
    name  = "server.ingress.hosts[0].paths[0]"
    value = var.ingress_path
  }
}

# module "eks_cluster" {
#   source = "terraform-aws-modules/eks/aws"
#   # ...
# }