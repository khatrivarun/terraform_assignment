resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_router" "router" {
  name    = "router-${random_string.random.result}"
  region  = var.region
  network = var.network

  bgp {
    asn = 65534
  }
}
