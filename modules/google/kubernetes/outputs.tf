output "service_name" {
  value = kubernetes_service.k8s_service.metadata.0.name
}
