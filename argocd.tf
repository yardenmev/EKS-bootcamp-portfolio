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
  # set {
  #   name  = "server.ingress.hosts"
  #   value = "yarden-argo.duckdns.org"
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

resource "null_resource" "app_of_apps" {
  depends_on = [
    helm_release.argocd
  ]
  provisioner "local-exec" {
    command = "kubectl apply -f /home/ubuntu/infrastructure-bootcamp-portfolio/argocd-values.yaml"
    when    = create
  }
  
}



