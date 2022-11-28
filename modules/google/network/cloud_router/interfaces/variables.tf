variable "cgw_internal_ip_ranges" {
  type = map(any)
}

variable "tunnels" {
  type = map(any)
}

variable "cgw_bgp_asns" {
  type = map(any)
}

variable "vgw_internal_ips" {
  type = map(any)
}

variable "router" {
  type = string
}
