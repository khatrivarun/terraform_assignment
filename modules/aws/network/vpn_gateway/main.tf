resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id          = var.vpc_id
  amazon_side_asn = var.amz_asn
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = var.vpc_id
  vpn_gateway_id = aws_vpn_gateway.vpn_gateway.id
}

resource "aws_vpn_connection" "interface_0_cgw_connection" {
  customer_gateway_id = var.cgw_interfaces["interface_0"]
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  type                = "ipsec.1"
  static_routes_only  = false
}

resource "aws_vpn_connection" "interface_1_cgw_connection" {
  customer_gateway_id = var.cgw_interfaces["interface_1"]
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  type                = "ipsec.1"
  static_routes_only  = false
}
