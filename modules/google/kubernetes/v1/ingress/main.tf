provider "kubernetes" {
  host                   = "https://${var.gke_host}"
  token                  = var.gke_token
  cluster_ca_certificate = base64decode(var.gke_ca_certificate)
}

resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name = var.app_name
  }

  spec {
    default_backend {
      service {
        name = var.service_name
        port {
          number = var.exposed_port
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = var.service_name
              port {
                number = var.exposed_port
              }
            }
          }

          path = var.ingress_path
        }
      }
    }
  }
}

