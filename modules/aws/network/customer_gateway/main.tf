resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_customer_gateway" "customer_gateway_interface_0" {
  bgp_asn    = var.google_asn
  ip_address = var.google_interfaces["interface_0"]
  type       = "ipsec.1"
}

resource "aws_customer_gateway" "customer_gateway_interface_1" {
  bgp_asn    = var.google_asn
  ip_address = var.google_interfaces["interface_1"]
  type       = "ipsec.1"
}
