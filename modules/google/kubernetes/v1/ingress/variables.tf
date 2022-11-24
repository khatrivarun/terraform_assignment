variable "gke_host" {
  type        = string
  description = "GKE Host String"
}

variable "gke_token" {
  type        = string
  description = "GKE Auth Token"
}

variable "gke_ca_certificate" {
  type        = string
  description = "GKE Cluster CA Certificate"
}

variable "app_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "exposed_port" {
  type = number
}

variable "ingress_path" {
  type = string
}
