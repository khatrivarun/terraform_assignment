resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_health_check" "vm_health_check" {
  count              = var.backend_mode == "TCP_EXTERNAL" || var.backend_mode == "TCP_INTERNAL" ? 1 : 0
  provider           = google-beta
  name               = "tcp-proxy-health-check-${random_string.random.result}"
  timeout_sec        = 1
  check_interval_sec = 1

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_backend_service" "tcp_external_backend_service" {
  count                 = var.backend_mode == "TCP_EXTERNAL" ? 1 : 0
  provider              = google-beta
  name                  = "tcp-backend-service-${random_string.random.result}"
  protocol              = "TCP"
  port_name             = "tcp"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.vm_health_check.0.id]
  backend {
    group           = var.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 1.0
    capacity_scaler = 1.0
  }
}

resource "google_compute_region_backend_service" "tcp_internal_backend_service" {
  count                 = var.backend_mode == "TCP_INTERNAL" ? 1 : 0
  name                  = "tcp-backend-service-${random_string.random.result}"
  provider              = google-beta
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  health_checks         = [google_compute_health_check.vm_health_check.0.id]
  backend {
    group          = var.instance_group
    balancing_mode = "CONNECTION"
  }
}

resource "google_compute_region_health_check" "vm_health_check" {
  count = var.backend_mode == "HTTP_EXTERNAL" ? 1 : 0
  name  = "vm-health-check-${random_string.random.result}"
  tcp_health_check {
    port = 80
  }
}

resource "google_compute_region_backend_service" "http_external_backend_service" {
  count                 = var.backend_mode == "HTTP_EXTERNAL" ? 1 : 0
  name                  = "http-backend-service-${random_string.random.result}"
  protocol              = "UNSPECIFIED"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10

  health_checks = [google_compute_region_health_check.vm_health_check.0.id]

  backend {
    group = var.instance_group
  }
}

resource "google_compute_backend_service" "http_proxy_backend_service" {
  count       = var.backend_mode == "HTTP_PROXY" ? 1 : 0
  name        = "http-proxy-backend-service-${random_string.random.result}"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [var.health_check_id]

  backend {
    group = var.instance_group
  }
}
