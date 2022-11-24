resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_router_interface" "int_1" {
  name       = "interface-1-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnel_1
  ip_range   = "${var.cgw_1_tunnel_1_internal_ip_range}/30"
}

resource "google_compute_router_interface" "int_2" {
  name       = "interface-2-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnel_2
  ip_range   = "${var.cgw_1_tunnel_2_internal_ip_range}/30"
}

resource "google_compute_router_interface" "int_3" {
  name       = "interface-3-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnel_3
  ip_range   = "${var.cgw_2_tunnel_1_internal_ip_range}/30"
}

resource "google_compute_router_interface" "int_4" {
  name       = "interface-4-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnel_4
  ip_range   = "${var.cgw_2_tunnel_2_internal_ip_range}/30"
}

resource "google_compute_router_peer" "peer_1" {
  name            = "aws-conn1-tunn1-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_1_tunnel_1_internal_bgp_asn
  interface       = google_compute_router_interface.int_1.id
  peer_ip_address = var.vgw_1_tunnel_1_internal_ip_range
}

resource "google_compute_router_peer" "peer_2" {
  name            = "aws-conn1-tunn2-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_1_tunnel_2_internal_bgp_asn
  interface       = google_compute_router_interface.int_2.id
  peer_ip_address = var.vgw_1_tunnel_2_internal_ip_range
}

resource "google_compute_router_peer" "peer_3" {
  name            = "aws-conn2-tunn1-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_2_tunnel_1_internal_bgp_asn
  interface       = google_compute_router_interface.int_3.id
  peer_ip_address = var.vgw_2_tunnel_1_internal_ip_range
}

resource "google_compute_router_peer" "peer_4" {
  name            = "aws-conn2-tunn2-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_2_tunnel_2_internal_bgp_asn
  interface       = google_compute_router_interface.int_4.id
  peer_ip_address = var.vgw_2_tunnel_2_internal_ip_range
}
