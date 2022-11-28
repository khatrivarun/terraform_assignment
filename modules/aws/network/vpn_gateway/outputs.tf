output "vpn_gateway_id" {
  value = aws_vpn_gateway.vpn_gateway.id
}

output "cgw_tunnels" {
  value = {
    "interface_0" : {
      "tunnel_1" : aws_vpn_connection.interface_0_cgw_connection.tunnel1_address
      "tunnel_2" : aws_vpn_connection.interface_0_cgw_connection.tunnel2_address
    }
    "interface_1" : {
      "tunnel_1" : aws_vpn_connection.interface_1_cgw_connection.tunnel1_address
      "tunnel_2" : aws_vpn_connection.interface_1_cgw_connection.tunnel2_address
    }
  }
}

output "cgw_shared_secrets" {
  value = {
    "interface_0" : {
      "tunnel_1" : aws_vpn_connection.interface_0_cgw_connection.tunnel1_preshared_key
      "tunnel_2" : aws_vpn_connection.interface_0_cgw_connection.tunnel2_preshared_key
    }
    "interface_1" : {
      "tunnel_1" : aws_vpn_connection.interface_1_cgw_connection.tunnel1_preshared_key
      "tunnel_2" : aws_vpn_connection.interface_1_cgw_connection.tunnel2_preshared_key
    }
  }
}

output "cgw_internal_ips" {
  value = {
    "interface_0" : {
      "tunnel_1" : aws_vpn_connection.interface_0_cgw_connection.tunnel1_cgw_inside_address
      "tunnel_2" : aws_vpn_connection.interface_0_cgw_connection.tunnel2_cgw_inside_address
    }
    "interface_1" : {
      "tunnel_1" : aws_vpn_connection.interface_1_cgw_connection.tunnel1_cgw_inside_address
      "tunnel_2" : aws_vpn_connection.interface_1_cgw_connection.tunnel2_cgw_inside_address
    }
  }
}

output "cgw_internal_ip_ranges" {
  value = {
    "interface_0" : {
      "tunnel_1" : "${aws_vpn_connection.interface_0_cgw_connection.tunnel1_cgw_inside_address}/30"
      "tunnel_2" : "${aws_vpn_connection.interface_0_cgw_connection.tunnel2_cgw_inside_address}/30"
    }
    "interface_1" : {
      "tunnel_1" : "${aws_vpn_connection.interface_1_cgw_connection.tunnel1_cgw_inside_address}/30"
      "tunnel_2" : "${aws_vpn_connection.interface_1_cgw_connection.tunnel2_cgw_inside_address}/30"
    }
  }
}

output "vgw_internal_ips" {
  value = {
    "interface_0" : {
      "tunnel_1" : aws_vpn_connection.interface_0_cgw_connection.tunnel1_vgw_inside_address
      "tunnel_2" : aws_vpn_connection.interface_0_cgw_connection.tunnel2_vgw_inside_address
    }
    "interface_1" : {
      "tunnel_1" : aws_vpn_connection.interface_1_cgw_connection.tunnel1_vgw_inside_address
      "tunnel_2" : aws_vpn_connection.interface_1_cgw_connection.tunnel2_vgw_inside_address
    }
  }
}

output "cgw_bgp_asns" {
  value = {
    "interface_0" : {
      "tunnel_1" : aws_vpn_connection.interface_0_cgw_connection.tunnel1_bgp_asn
      "tunnel_2" : aws_vpn_connection.interface_0_cgw_connection.tunnel2_bgp_asn
    }
    "interface_1" : {
      "tunnel_1" : aws_vpn_connection.interface_1_cgw_connection.tunnel1_bgp_asn
      "tunnel_2" : aws_vpn_connection.interface_1_cgw_connection.tunnel2_bgp_asn
    }
  }
}

# output "cgw_1_tunnel_1_external_ip" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_address
# }

# output "cgw_1_tunnel_2_external_ip" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_address
# }

# output "cgw_2_tunnel_1_external_ip" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_address
# }

# output "cgw_2_tunnel_2_external_ip" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_address
# }

# output "cgw_1_tunnel_1_shared_secret" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_preshared_key
# }

# output "cgw_1_tunnel_2_shared_secret" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_preshared_key
# }

# output "cgw_2_tunnel_1_shared_secret" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_preshared_key
# }

# output "cgw_2_tunnel_2_shared_secret" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_preshared_key
# }

# output "cgw_1_tunnel_1_internal_ip_range" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_cgw_inside_address
# }

# output "cgw_1_tunnel_2_internal_ip_range" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_cgw_inside_address
# }

# output "cgw_2_tunnel_1_internal_ip_range" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_cgw_inside_address
# }

# output "cgw_2_tunnel_2_internal_ip_range" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_cgw_inside_address
# }

# output "vgw_1_tunnel_1_internal_ip_range" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_vgw_inside_address
# }

# output "vgw_1_tunnel_2_internal_ip_range" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_vgw_inside_address
# }

# output "vgw_2_tunnel_1_internal_ip_range" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_vgw_inside_address
# }

# output "vgw_2_tunnel_2_internal_ip_range" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_vgw_inside_address
# }

# output "cgw_1_tunnel_1_internal_bgp_asn" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel1_bgp_asn
# }

# output "cgw_1_tunnel_2_internal_bgp_asn" {
#   value = aws_vpn_connection.interface_0_cgw_connection.tunnel2_bgp_asn
# }

# output "cgw_2_tunnel_1_internal_bgp_asn" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel1_bgp_asn
# }

# output "cgw_2_tunnel_2_internal_bgp_asn" {
#   value = aws_vpn_connection.interface_1_cgw_connection.tunnel2_bgp_asn
# }
