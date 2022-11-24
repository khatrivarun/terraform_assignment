provider "kubernetes" {
  host                   = "https://${var.gke_host}"
  token                  = var.gke_token
  cluster_ca_certificate = base64decode(var.gke_ca_certificate)
}

resource "kubernetes_deployment" "k8s_deployment" {
  metadata {
    name = var.k8s_deployment_name
    labels = {
      deployment_name = var.k8s_deployment_name
    }
  }

  spec {
    replicas = var.k8s_replicas

    selector {
      match_labels = {
        deployment_name = var.k8s_deployment_name
      }
    }

    template {
      metadata {
        labels = {
          deployment_name = var.k8s_deployment_name
        }
      }

      spec {
        container {
          image = var.k8s_image
          name  = var.k8s_deployment_name

          port {
            container_port = var.k8s_container_port
          }

          resources {
            limits   = var.k8s_resource_limits
            requests = var.k8s_resource_requests
          }
        }
      }

    }

  }

}

resource "kubernetes_service" "k8s_service" {
  metadata {
    name = var.k8s_deployment_name
  }
  spec {
    selector = {
      deployment_name = kubernetes_deployment.k8s_deployment.spec.0.template.0.metadata[0].labels.deployment_name
    }
    port {
      port        = var.k8s_container_port
      target_port = var.k8s_target_container_port
    }

    type = var.k8s_service_type
  }
}
