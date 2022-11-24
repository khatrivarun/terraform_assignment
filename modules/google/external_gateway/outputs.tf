output "external_gateway_id" {
  value = google_compute_external_vpn_gateway.external_gateway.self_link
}

output "external_gateway_interfaces" {
  value = google_compute_external_vpn_gateway.external_gateway.interface
}
