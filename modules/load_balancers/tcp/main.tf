resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_region_target_tcp_proxy" "tcp_proxy" {
  provider        = google-beta
  name            = "tcp-proxy-${random_string.random.result}"
  backend_service = var.backend_service_id
}
