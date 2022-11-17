resource "google_sql_database_instance" "sql_instance" {
  name             = var.sql_name
  database_version = var.sql_version
  region           = var.sql_region

  deletion_protection = false

  settings {
    tier              = var.sql_tier
    availability_type = var.sql_availability
    disk_size         = var.sql_size

    backup_configuration {
      binary_log_enabled = true
      enabled            = true
    }
  }
}

resource "google_sql_user" "user" {
  name     = var.sql_username
  instance = google_sql_database_instance.sql_instance.name
  host     = "%"
  password = var.sql_password
}

resource "google_sql_database" "database" {
  name     = var.sql_db
  instance = google_sql_database_instance.sql_instance.name
}
