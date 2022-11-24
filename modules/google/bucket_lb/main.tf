resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_global_address" "address" {
  name = "gcs-address-${random_string.random.result}"
}

resource "google_compute_backend_bucket" "bucket_backend" {
  name        = "bucket-backend-${random_string.random.result}"
  bucket_name = var.bucket_name
}

resource "google_compute_url_map" "backend_url_map" {
  name            = "url-map-${random_string.random.result}"
  default_service = google_compute_backend_bucket.bucket_backend.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "path-matcher"
  }

  path_matcher {
    name            = "path-matcher"
    default_service = google_compute_backend_bucket.bucket_backend.id
  }

}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "lb-${random_string.random.result}"
  url_map = google_compute_url_map.backend_url_map.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "lb-fw-${random_string.random.result}"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_proxy.id
  ip_address            = google_compute_global_address.address.id
}
