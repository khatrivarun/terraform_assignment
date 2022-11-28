variable "vpn_gateway_id" {
  type = string
}

variable "external_gateway_id" {
  type = string
}

variable "router_url" {
  type = string
}

variable "cgw_shared_secrets" {
  type = map(any)
}
