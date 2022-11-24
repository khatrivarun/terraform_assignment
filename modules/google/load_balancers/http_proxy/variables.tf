variable "default_service_id" {
  type = string
}

variable "path_rules" {
  type = list(object({
    path               = string
    backend_service_id = string
  }))
}
