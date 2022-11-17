variable "bucket_name" {
  type        = string
  description = "GCS Bucket Name"
}

variable "backend_name" {
  type        = string
  description = "GCS Bucket Name"
}

variable "url_map_name" {
  type        = string
  description = "Load Balancer URL Map Name"
}

variable "load_balancer_name" {
  type        = string
  description = "Load Balancer Name"
}
