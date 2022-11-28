variable "vpc_id" {
  type = string
}

variable "amz_asn" {
  type    = string
  default = "65001"
}

variable "cgw_interfaces" {
  type = map(string)
}
