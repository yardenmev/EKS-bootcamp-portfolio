provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "${module.eks.cluster_id}"]
      command     = "aws"
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "4.9.7"
  create_namespace = true
  values     = [file("${path.module}/argocd-values.yaml")]
}

# resource "helm_release" "argocd" {
#   name       = "argocd"
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-cd"
#   namespace  = var.namespace
#   create_namespace = true
#   version    = "4.9.7"
#   values     = [file("${path.module}/argocd-values.yaml")]

#   depends_on = [module.eks]

#   set {
#     name  = "server.ingress.enabled"
#     value = var.ingress_enabled
#   }

#   set {
#     name  = "server.ingress.hosts[0].host"
#     value = var.ingress_host
#   }

#   set {
#     name  = "server.ingress.hosts[0].paths[0]"
#     value = var.ingress_path
#   }
# }

