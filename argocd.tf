resource "helm_release" "argocd" {
  name       = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.27.0"
  create_namespace = true
  # values     = [file("${path.module}/argocd-values.yaml")]
  # argo_helm_values 
  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }
  set {
    name  = "server.ingress.webhook.enabled"
    value = "true"
  }
   set {
    name  = "server.ingress.webhook.ingressClassName"
    value = "nginx"
  }
 
}

# resource "null_resource" "argo_password" {
#   depends_on = [
#     helm_release.argocd
#   ]
#   provisioner "local-exec" {
#     command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo"
#     when    = create
#   }
# }


