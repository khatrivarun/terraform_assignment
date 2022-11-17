variable "gke_cluster_name" {
  type        = string
  description = "GKE Cluster Name"
}

variable "gke_cluster_region" {
  type        = string
  description = "GKE Cluster Region"
}

variable "gke_node_pool_name" {
  type        = string
  description = "GKE Node Pool Name"
}

variable "gke_node_count" {
  type        = number
  description = "GKE Number of Nodes"
}
