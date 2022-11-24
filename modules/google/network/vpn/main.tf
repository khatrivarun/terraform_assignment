resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_ha_vpn_gateway" "ha_vpn" {
  provider = google-beta

  name    = "ha-vpn-${random_string.random.result}"
  region  = var.region
  network = var.network
}
