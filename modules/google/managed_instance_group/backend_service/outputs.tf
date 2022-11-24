output "backend_service_id" {
  value = length(google_compute_backend_service.tcp_external_backend_service) == 1 ? google_compute_backend_service.tcp_external_backend_service.0.id : length(google_compute_region_backend_service.http_external_backend_service) == 1 ? google_compute_region_backend_service.http_external_backend_service.0.id : length(google_compute_region_backend_service.tcp_internal_backend_service) == 1 ? google_compute_region_backend_service.tcp_internal_backend_service.0.id : google_compute_backend_service.http_proxy_backend_service.0.id
}
