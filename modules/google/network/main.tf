resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network-${random_string.random.result}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-${random_string.random.result}"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
}

resource "google_compute_router" "router" {
  name    = "router-${random_string.random.result}"
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "router-nat-${random_string.random.result}"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "ssh_firewall" {
  name    = "firewall-${random_string.random.result}"
  network = google_compute_network.vpc_network.id

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}
