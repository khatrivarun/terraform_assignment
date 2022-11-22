provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

# resource "random_string" "random" {
#   length  = 5
#   special = false
#   upper   = false
# }


# module "nginx_cluster" {
#   source             = "./modules/gke_cluster"
#   gke_cluster_name   = var.cluster_name
#   gke_cluster_region = var.cluster_region
#   gke_node_pool_name = var.cluster_node_pool_name
#   gke_node_count     = var.cluster_node_count
# }

# data "google_client_config" "default" {}

# module "k8s_nginx" {
#   source                    = "./modules/kubernetes"
#   gke_host                  = module.nginx_cluster.gke_host
#   gke_token                 = data.google_client_config.default.access_token
#   gke_ca_certificate        = module.nginx_cluster.gke_cluster_ca_certificate
#   k8s_replicas              = var.k8s_replicas
#   k8s_deployment_name       = var.k8s_deployment_name
#   k8s_image                 = var.k8s_image
#   k8s_resource_limits       = var.k8s_resource_limits
#   k8s_resource_requests     = var.k8s_resource_requests
#   k8s_container_port        = var.k8s_container_port
#   k8s_target_container_port = var.k8s_target_container_port
#   k8s_service_type          = var.k8s_service_type
# }

# module "cat_bucket" {
#   source          = "./modules/cloud_storage"
#   bucket_name     = var.bucket_name
#   bucket_location = var.bucket_location
#   object_name     = var.object_name
#   object_location = var.object_location
#   is_public       = true
# }

# module "cat_bucket_lb" {
#   source      = "./modules/bucket_lb"
#   bucket_name = module.cat_bucket.bucket_name
# }

# module "gcp-sql" {
#   source           = "./modules/sql"
#   sql_name         = var.sql_name
#   sql_version      = var.sql_version
#   sql_region       = var.sql_region
#   sql_tier         = var.sql_tier
#   sql_availability = var.sql_availability
#   sql_size         = var.sql_size
#   sql_username     = var.sql_username
#   sql_password     = var.sql_password
#   sql_db           = var.sql_db
# }

# data "archive_file" "source" {
#   type        = "zip"
#   source_dir  = "./code"
#   output_path = "./function.zip"
# }

# resource "google_storage_bucket" "upload_bucket" {
#   name                        = "${var.upload_bucket_name}-${random_string.random.result}"
#   location                    = var.upload_bucket_location
#   uniform_bucket_level_access = true
#   force_destroy               = true
#   storage_class               = "STANDARD"
# }

# module "code_bucket" {
#   source          = "./modules/cloud_storage"
#   bucket_name     = var.code_bucket_name
#   bucket_location = var.bucket_location
#   object_name     = var.code_object_name
#   object_location = data.archive_file.source.output_path
#   is_public       = false

#   depends_on = [
#     google_storage_bucket.upload_bucket
#   ]
# }

# resource "google_cloudfunctions_function" "function" {
#   name    = "${var.cf_name}-${random_string.random.result}"
#   runtime = "python37"

#   source_archive_bucket = module.code_bucket.bucket_name
#   source_archive_object = module.code_bucket.object_name

#   entry_point = "main"

#   event_trigger {
#     event_type = "google.storage.object.finalize"
#     resource   = google_storage_bucket.upload_bucket.name
#   }
# }

# // Modularize it.
# resource "google_secret_manager_secret" "secret-basic" {
#   secret_id = "secret"

#   replication {
#     user_managed {
#       replicas {
#         location = "us-central1"
#       }
#     }
#   }
# }

# resource "google_secret_manager_secret_version" "secret-version-basic" {
#   secret = google_secret_manager_secret.secret-basic.id

#   secret_data = "secret-data"
# }

module "managed_instance_group" {
  source         = "./modules/managed_instance_group"
  machine_type   = "e2-medium"
  source_image   = "debian-cloud/debian-11"
  network_name   = "default"
  startup_script = <<EOT

  #!/bin/bash
  apt update
  apt -y install apache2
  echo "Hello world from $(hostname) $(hostname -I)" > /var/www/html/index.html
  EOT
}

# resource "google_compute_backend_service" "default" {
#   name        = "backend-service"
#   port_name   = "http"
#   protocol    = "HTTP"
#   timeout_sec = 10

#   health_checks = [google_compute_http_health_check.default.id]

#   backend {
#     group = google_compute_instance_group_manager.mig.instance_group
#   }
# }

# resource "google_compute_target_http_proxy" "default" {
#   name    = "test-proxy"
#   url_map = google_compute_url_map.default.id
# }

# resource "google_compute_url_map" "default" {
#   name            = "url-map"
#   default_service = google_compute_backend_service.default.id

#   host_rule {
#     hosts        = ["*"]
#     path_matcher = "allpaths"
#   }

#   path_matcher {
#     name            = "allpaths"
#     default_service = google_compute_backend_service.default.id
#   }
# }

