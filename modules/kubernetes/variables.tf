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

variable "k8s_replicas" {
  type        = number
  description = "K8s Number of Replicas"
}

variable "k8s_deployment_name" {
  type        = string
  description = "K8s Deployment Name"
}

variable "k8s_image" {
  type        = string
  description = "K8s Deployment Name"
}

variable "k8s_resource_limits" {
  type        = map(string)
  description = "K8s Resource Limits"
}

variable "k8s_resource_requests" {
  type        = map(string)
  description = "K8s Resource Requests"
}

variable "k8s_container_port" {
  type        = number
  description = "K8s Container Port"
}

variable "k8s_target_container_port" {
  type        = number
  description = "K8s Target Container Port"
}

variable "k8s_service_type" {
  type        = string
  description = "K8s Service Type"
}
