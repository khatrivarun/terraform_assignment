resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_container_cluster" "gke_cluster" {
  name     = "${var.gke_cluster_name}-${random_string.random.result}"
  location = var.gke_cluster_region

  initial_node_count       = 1
  remove_default_node_pool = true

  node_config {
    machine_type = "e2-small"
  }
}

resource "google_container_node_pool" "gke_node_pool" {
  name       = "${var.gke_node_pool_name}-${random_string.random.result}"
  location   = var.gke_cluster_region
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.gke_node_count

  node_config {
    machine_type = "e2-small"
  }
}
