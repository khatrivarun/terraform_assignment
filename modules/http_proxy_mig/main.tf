resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_backend_service" "default" {
  name        = "backend-service-${random_string.random.result}"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [var.health_check_id]

  backend {
    group = var.instance_group
  }
}

resource "google_compute_target_http_proxy" "default" {
  name    = "test-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_service.default.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.default.id
  }
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "lb-fw-${random_string.random.result}"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_proxy.id
  ip_address            = google_compute_global_address.address.id
}
