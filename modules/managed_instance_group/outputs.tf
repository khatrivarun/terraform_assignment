output "health_check_id" {
  value = google_compute_region_health_check.vm_health_check.id
}

output "instance_group" {
  value = google_compute_instance_group_manager.managed_instance_group.instance_group
}

output "backend_service_id" {
  value = google_compute_region_backend_service.backend_service.id
}
