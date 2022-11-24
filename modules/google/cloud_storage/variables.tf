variable "bucket_name" {
  type        = string
  description = "GCS Bucket Name"
}

variable "bucket_location" {
  type        = string
  description = "GCS Location"
}

variable "object_name" {
  type        = string
  description = "GCS Object Name"
}

variable "object_location" {
  type        = string
  description = "GCS Object Location"
  default     = "./images/cat.jpg"
}

variable "is_public" {
  type        = bool
  description = "Keep GCS Bucket internet accessible or not."
}
