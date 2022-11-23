resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_global_address" "address" {
  name = "gcs-address-${random_string.random.result}"
}

resource "google_compute_url_map" "url_map" {
  name            = "load-balancer-${random_string.random.result}"
  default_service = var.default_service_id

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = var.default_service_id

    dynamic "path_rule" {
      for_each = var.path_rules
      content {
        paths   = [path_rule.value.path]
        service = path_rule.value.backend_service_id
      }
    }
  }
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy-${random_string.random.result}"
  url_map = google_compute_url_map.url_map.id
}


resource "google_compute_global_forwarding_rule" "load_balancer_fw_rule" {
  name                  = "lb-fw-${random_string.random.result}"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_proxy.id
  ip_address            = google_compute_global_address.address.id
}
