variable "vpc_id" {
  type = string
}

variable "amz_asn" {
  type    = string
  default = "65001"
}

variable "interface_0_cgw_id" {
  type = string
}

variable "interface_1_cgw_id" {
  type = string
}
