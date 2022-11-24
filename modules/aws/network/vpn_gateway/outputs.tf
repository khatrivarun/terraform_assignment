output "vpn_gateway_id" {
  value = aws_vpn_gateway.vpn_gateway.id
}

output "cgw_1_tunnel_1_external_ip" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_address
}

output "cgw_1_tunnel_2_external_ip" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_address
}

output "cgw_2_tunnel_1_external_ip" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_address
}

output "cgw_2_tunnel_2_external_ip" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_address
}

output "cgw_1_tunnel_1_shared_secret" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_preshared_key
}

output "cgw_1_tunnel_2_shared_secret" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_preshared_key
}

output "cgw_2_tunnel_1_shared_secret" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_preshared_key
}

output "cgw_2_tunnel_2_shared_secret" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_preshared_key
}

output "cgw_1_tunnel_1_internal_ip_range" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_cgw_inside_address
}

output "cgw_1_tunnel_2_internal_ip_range" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_cgw_inside_address
}

output "cgw_2_tunnel_1_internal_ip_range" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_cgw_inside_address
}

output "cgw_2_tunnel_2_internal_ip_range" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_cgw_inside_address
}

output "vgw_1_tunnel_1_internal_ip_range" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_vgw_inside_address
}

output "vgw_1_tunnel_2_internal_ip_range" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_vgw_inside_address
}

output "vgw_2_tunnel_1_internal_ip_range" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_vgw_inside_address
}

output "vgw_2_tunnel_2_internal_ip_range" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_vgw_inside_address
}

output "cgw_1_tunnel_1_internal_bgp_asn" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_bgp_asn
}

output "cgw_1_tunnel_2_internal_bgp_asn" {
  value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_bgp_asn
}

output "cgw_2_tunnel_1_internal_bgp_asn" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_bgp_asn
}

output "cgw_2_tunnel_2_internal_bgp_asn" {
  value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_bgp_asn
}
