resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  provider = google-beta

  name = "tunnel-1-${random_string.random.result}"

  peer_external_gateway           = var.external_gateway_id
  peer_external_gateway_interface = 0
  ike_version                     = 2
  shared_secret                   = var.cgw_1_tunnel_1_shared_secret
  router                          = var.router_url
  vpn_gateway                     = var.vpn_gateway_id
  vpn_gateway_interface           = 0
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  provider = google-beta

  name = "tunnel-2-${random_string.random.result}"

  peer_external_gateway           = var.external_gateway_id
  peer_external_gateway_interface = 1
  ike_version                     = 2
  shared_secret                   = var.cgw_1_tunnel_2_shared_secret
  router                          = var.router_url
  vpn_gateway                     = var.vpn_gateway_id
  vpn_gateway_interface           = 0
}

resource "google_compute_vpn_tunnel" "tunnel3" {
  provider = google-beta

  name = "tunnel-3-${random_string.random.result}"

  peer_external_gateway           = var.external_gateway_id
  peer_external_gateway_interface = 2
  ike_version                     = 2
  shared_secret                   = var.cgw_2_tunnel_1_shared_secret
  router                          = var.router_url
  vpn_gateway                     = var.vpn_gateway_id
  vpn_gateway_interface           = 1
}

resource "google_compute_vpn_tunnel" "tunnel4" {
  provider = google-beta

  name = "tunnel-4-${random_string.random.result}"

  peer_external_gateway           = var.external_gateway_id
  peer_external_gateway_interface = 3
  ike_version                     = 2
  shared_secret                   = var.cgw_2_tunnel_2_shared_secret
  router                          = var.router_url
  vpn_gateway                     = var.vpn_gateway_id
  vpn_gateway_interface           = 1
}
