output "bgp_asn" {
  value = google_compute_router.router.bgp.0.asn
}

output "url" {
  value = google_compute_router.router.name
}
