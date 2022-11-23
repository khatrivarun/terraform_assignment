resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_address" "address" {
  name = "gcs-address-${random_string.random.result}"
}


resource "google_compute_forwarding_rule" "load_balancer_fw_rule" {
  name                  = "lb-fw-${random_string.random.result}"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  ip_address            = google_compute_address.address.id
  backend_service       = var.service_id
}
