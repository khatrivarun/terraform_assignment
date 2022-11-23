resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_global_address" "address" {
  provider = google-beta
  name     = "address-${random_string.random.result}"
}

resource "google_compute_target_tcp_proxy" "tcp_proxy_external" {
  count           = var.mode == "EXTERNAL" ? 1 : 0
  provider        = google-beta
  name            = "tcp-proxy-${random_string.random.result}"
  backend_service = var.backend_service_id
}

resource "google_compute_global_forwarding_rule" "tcp_proxy_external" {
  count                 = var.mode == "EXTERNAL" ? 1 : 0
  name                  = "tcp-proxy-lb-fw-${random_string.random.result}"
  provider              = google-beta
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = var.port_range
  target                = google_compute_target_tcp_proxy.tcp_proxy_external.0.id
  ip_address            = google_compute_global_address.address.id
}

resource "google_compute_forwarding_rule" "tcp_proxy_internal" {
  count                 = var.mode == "INTERNAL" ? 1 : 0
  name                  = "tcp-proxy-lb-fw-${random_string.random.result}"
  backend_service       = var.backend_service_id
  provider              = google-beta
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  allow_global_access   = true
  network               = var.network
  subnetwork            = var.subnetwork
}
