resource "helm_release" "argocd" {
  name       = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.27.0"
  create_namespace = true
 
  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }
  set {
    name  = "server.ingress.enabled"
    value = "true"
  }
   set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }
  #  set {
  #   name  = "server.ingress.paths"
  #   value = "/argocd"
  # }
  # set {
  #   name  = "server.ingress.annotations"
  #   value = "nginx.ingress.kubernetes.io/rewrite-target: /"
  # }
 
}

resource "null_resource" "argo_password" {
  depends_on = [
    helm_release.argocd
  ]
  provisioner "local-exec" {
    command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d "
    when    = create
  }
}



# provider "argocd" {
#   server_addr = "https://kubernetes.default.svc"
#   api_version = "client.authentication.k8s.io/v1beta1"
# }

# resource "argocd_application" "todo" {
#   metadata {
#     name      = "todo-app"
#     namespace = "default" 
#   }
#   spec {
#     project = "myproject"
#     source {
#     repo_url = "https://github.com/yardenmev/GitOps-bootcamp-portfolio"
#     path            = "todo-chart"
#     target_revision = "HEAD"
#     }
#   }
#   destination {
#     server    = "https://kubernetes.default.svc"
#     namespace = "default"
#   }
# }

