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
    ip_address = var.cgw_tunnels["interface_0"]["tunnel_1"]
  }

  interface {
    id         = 1
    ip_address = var.cgw_tunnels["interface_0"]["tunnel_2"]
  }

  interface {
    id         = 2
    ip_address = var.cgw_tunnels["interface_1"]["tunnel_1"]
  }

  interface {
    id         = 3
    ip_address = var.cgw_tunnels["interface_1"]["tunnel_2"]
  }
}
