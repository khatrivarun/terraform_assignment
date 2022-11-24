output "interface_0_public_ip" {
  value = google_compute_ha_vpn_gateway.ha_vpn.vpn_interfaces.0.ip_address
}

output "interface_1_public_ip" {
  value = google_compute_ha_vpn_gateway.ha_vpn.vpn_interfaces.1.ip_address
}

output "vpn_interfaces" {
  value = google_compute_ha_vpn_gateway.ha_vpn.vpn_interfaces
}

output "vpn_gateway" {
  value = google_compute_ha_vpn_gateway.ha_vpn.self_link
}
