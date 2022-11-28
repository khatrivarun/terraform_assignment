output "public_ip_interfaces" {
  value = {
    "interface_0" : google_compute_ha_vpn_gateway.ha_vpn.vpn_interfaces.0.ip_address
    "interface_1" : google_compute_ha_vpn_gateway.ha_vpn.vpn_interfaces.1.ip_address
  }
}

output "vpn_interfaces" {
  value = google_compute_ha_vpn_gateway.ha_vpn.vpn_interfaces
}

output "vpn_gateway" {
  value = google_compute_ha_vpn_gateway.ha_vpn.self_link
}
