output "tunnels" {
  value = {
    "tunnel_1" : google_compute_vpn_tunnel.tunnel1.name
    "tunnel_2" : google_compute_vpn_tunnel.tunnel2.name
    "tunnel_3" : google_compute_vpn_tunnel.tunnel3.name
    "tunnel_4" : google_compute_vpn_tunnel.tunnel4.name
  }
}
