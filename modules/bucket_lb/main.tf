resource "google_compute_global_address" "address" {
  name = "gcs-address"
}

resource "google_compute_backend_bucket" "bucket_backend" {
  name        = var.backend_name
  description = "Contains cat image"
  bucket_name = var.bucket_name
}

resource "google_compute_url_map" "backend_url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_bucket.bucket_backend.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "path-matcher"
  }

  path_matcher {
    name            = "path-matcher"
    default_service = google_compute_backend_bucket.bucket_backend.id

    path_rule {
      paths   = ["/images/*"]
      service = google_compute_backend_bucket.bucket_backend.id
    }
  }

}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = var.load_balancer_name
  url_map = google_compute_url_map.backend_url_map.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "http-lb-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_proxy.id
  ip_address            = google_compute_global_address.address.id
}
