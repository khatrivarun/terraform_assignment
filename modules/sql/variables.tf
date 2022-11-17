variable "sql_name" {
  type        = string
  description = "Cloud SQL Name"
}

variable "sql_version" {
  type        = string
  description = "Cloud SQL Version"
}

variable "sql_region" {
  type        = string
  description = "Cloud SQL Region"
}

variable "sql_tier" {
  type        = string
  description = "Cloud SQL Tier"
}

variable "sql_availability" {
  type        = string
  description = "Cloud SQL Availability Type"
}

variable "sql_size" {
  type        = number
  description = "Cloud SQL Size"
}

variable "sql_username" {
  type        = string
  description = "Cloud SQL Username"
}

variable "sql_password" {
  type        = string
  description = "Cloud SQL Password"
}

variable "sql_db" {
  type        = string
  description = "Cloud SQL Database name"
}
