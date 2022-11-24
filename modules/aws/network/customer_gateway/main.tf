resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_customer_gateway" "customer_gateway_interface_0" {
  bgp_asn    = var.google_asn
  ip_address = var.google_interface_0_public_ip
  type       = "ipsec.1"
}

resource "aws_customer_gateway" "customer_gateway_interface_1" {
  bgp_asn    = var.google_asn
  ip_address = var.google_interface_1_public_ip
  type       = "ipsec.1"
}
