output "cgw_interfaces" {
  value = {
    "interface_0" : aws_customer_gateway.customer_gateway_interface_0.id
    "interface_1" : aws_customer_gateway.customer_gateway_interface_1.id
  }
}
