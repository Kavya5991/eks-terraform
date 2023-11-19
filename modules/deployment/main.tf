resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-deploy"
  }

  spec {
    replicas = var.nginx_replicas

    selector {
      match_labels = {
        app = "nginx-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-app"
        }
      }

      spec {
        container {
          image = var.nginx_image
          name  = "nginx-app"


          
    }
  }
}
  }
}