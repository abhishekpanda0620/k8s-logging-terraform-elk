resource "kubernetes_deployment" "user_crud" {
  metadata {
    name      = var.app_name
    namespace = "default"
    labels = {
      app = "user-crud"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "user-crud"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-crud"
        }
      }
      spec {
        container {
          name  = "user-crud"
          image = var.docker_image
          image_pull_policy = "Always"
          port {
            container_port = 80
          }
          readiness_probe {
            http_get {
              path = "/health"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          liveness_probe {
            http_get {
              path = "/health"
              port = 80
            }
            initial_delay_seconds = 15
            period_seconds        = 20
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user_crud" {
  metadata {
    name = var.app_name
  }
  spec {
    selector = {
      app = kubernetes_deployment.user_crud.metadata[0].labels["app"]
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}
