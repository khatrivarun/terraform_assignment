variable "gcp_project" {
  description = "GCP Project to use."
  type        = string
}

variable "gcp_region" {
  description = "GCP Region."
  type        = string
}

variable "cluster_name" {
  description = "GKE Cluster Name."
  type        = string
}

variable "cluster_region" {
  description = "GKE Cluster Region."
  type        = string
}

variable "cluster_node_pool_name" {
  description = "GKE Cluster Node Pool Name."
  type        = string
}

variable "cluster_node_count" {
  description = "GKE Node Count."
  type        = number
}

variable "k8s_replicas" {
  description = "K8s Replica."
  type        = number
}

variable "k8s_deployment_name" {
  description = "K8s Deployment Name"
  type        = string
}

variable "k8s_image" {
  description = "K8s Image"
  type        = string
}

variable "k8s_resource_limits" {
  description = "K8s Resource Limits"
  type        = map(string)
}

variable "k8s_resource_requests" {
  description = "K8s Resource Requests"
  type        = map(string)
}

variable "k8s_container_port" {
  description = "K8s Container Port"
  type        = number
}

variable "k8s_target_container_port" {
  description = "K8s Target Container Port"
  type        = number
}

variable "k8s_service_type" {
  description = "K8s Service Type"
  type        = string
}

variable "bucket_name" {
  description = "GCS Bucket Name"
  type        = string
}

variable "bucket_location" {
  description = "GCS Location"
  type        = string
}

variable "object_name" {
  description = "GCS Object Name"
  type        = string
}

variable "object_location" {
  description = "GCS Object Location"
  type        = string
}

variable "sql_name" {
  description = "SQL Name"
  type        = string
}

variable "sql_version" {
  description = "SQL Version"
  type        = string
}

variable "sql_region" {
  description = "SQL Region"
  type        = string
}

variable "sql_tier" {
  description = "SQL Tier"
  type        = string
}

variable "sql_availability" {
  description = "SQL Availability"
  type        = string
}

variable "sql_size" {
  description = "SQL Size"
  type        = number
}

variable "sql_username" {
  description = "SQL Username"
  type        = string
}

variable "sql_password" {
  description = "SQL Password"
  type        = string
}

variable "sql_db" {
  description = "SQL Database Name"
  type        = string
}

variable "upload_bucket_name" {
  description = "Upload Bucket Name"
  type        = string
}

variable "upload_bucket_location" {
  description = "Upload Location"
  type        = string
}

variable "code_bucket_name" {
  description = "Code Bucket Name"
  type        = string
}

variable "code_object_name" {
  description = "Code Object Name"
  type        = string
}

variable "cf_name" {
  description = "Cloud Functions Name"
  type        = string
}
