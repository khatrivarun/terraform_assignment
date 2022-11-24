resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_external_vpn_gateway" "external_gateway" {
  name            = "external-gateway-${random_string.random.result}"
  redundancy_type = "FOUR_IPS_REDUNDANCY"

  interface {
    id         = 0
    ip_address = var.cgw_1_tunnel_1_external_ip
  }

  interface {
    id         = 1
    ip_address = var.cgw_1_tunnel_2_external_ip
  }

  interface {
    id         = 2
    ip_address = var.cgw_2_tunnel_1_external_ip
  }

  interface {
    id         = 3
    ip_address = var.cgw_2_tunnel_2_external_ip
  }
}
