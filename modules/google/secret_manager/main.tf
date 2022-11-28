resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret-${random_string.random.result}"

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
    }
  }
}

resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id

  secret_data = var.secret
}
