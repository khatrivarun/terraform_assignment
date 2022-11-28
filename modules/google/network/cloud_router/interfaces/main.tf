resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_router_interface" "int_1" {
  name       = "interface-1-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnels["tunnel_1"]
  ip_range   = var.cgw_internal_ip_ranges["interface_0"]["tunnel_1"]
}

resource "google_compute_router_interface" "int_2" {
  name       = "interface-2-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnels["tunnel_2"]
  ip_range   = var.cgw_internal_ip_ranges["interface_0"]["tunnel_2"]
}

resource "google_compute_router_interface" "int_3" {
  name       = "interface-3-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnels["tunnel_3"]
  ip_range   = var.cgw_internal_ip_ranges["interface_1"]["tunnel_1"]
}

resource "google_compute_router_interface" "int_4" {
  name       = "interface-4-${random_string.random.result}"
  router     = var.router
  vpn_tunnel = var.tunnels["tunnel_4"]
  ip_range   = var.cgw_internal_ip_ranges["interface_1"]["tunnel_2"]
}

resource "google_compute_router_peer" "peer_1" {
  name            = "aws-conn1-tunn1-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_bgp_asns["interface_0"]["tunnel_1"]
  interface       = google_compute_router_interface.int_1.id
  peer_ip_address = var.vgw_internal_ips["interface_0"]["tunnel_1"]
}

resource "google_compute_router_peer" "peer_2" {
  name            = "aws-conn1-tunn2-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_bgp_asns["interface_0"]["tunnel_2"]
  interface       = google_compute_router_interface.int_2.id
  peer_ip_address = var.vgw_internal_ips["interface_0"]["tunnel_2"]
}

resource "google_compute_router_peer" "peer_3" {
  name            = "aws-conn2-tunn1-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_bgp_asns["interface_1"]["tunnel_1"]
  interface       = google_compute_router_interface.int_3.id
  peer_ip_address = var.vgw_internal_ips["interface_1"]["tunnel_1"]
}

resource "google_compute_router_peer" "peer_4" {
  name            = "aws-conn2-tunn2-${random_string.random.result}"
  router          = var.router
  peer_asn        = var.cgw_bgp_asns["interface_1"]["tunnel_1"]
  interface       = google_compute_router_interface.int_4.id
  peer_ip_address = var.vgw_internal_ips["interface_1"]["tunnel_2"]
}
