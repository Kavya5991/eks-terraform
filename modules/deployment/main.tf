resource "kubernetes_deployment" "nginx" {
  metadata {
    name = var.deploy_name
  }

  spec {
    replicas = var.nginx_replicas

    selector {
      match_labels = {
        app = var.label_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.label_name
        }
      }

      spec {
        container {
          image = var.nginx_image
          name  = var.container_name


          
    }
  }
}
strategy {
    type = "RollingUpdate"

    rolling_update {
      max_surge       = var.max_surge_percentage
      max_unavailable = var.max_unavailable_percentage
    }
  }
}
}