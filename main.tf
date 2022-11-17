provider "google" {
  project = "q-assignment"
  region  = "us-east1"
}


module "nginx_cluster" {
  source             = "./modules/gke_cluster"
  gke_cluster_name   = "cluster-1"
  gke_cluster_region = "us-east1"
  gke_node_pool_name = "nginx-node-pool"
  gke_node_count     = 1
}

data "google_client_config" "default" {}

module "k8s_nginx" {
  source              = "./modules/kubernetes"
  gke_host            = module.nginx_cluster.gke_host
  gke_token           = data.google_client_config.default.access_token
  gke_ca_certificate  = module.nginx_cluster.gke_cluster_ca_certificate
  k8s_replicas        = 1
  k8s_deployment_name = "nginx"
  k8s_image           = "nginx"
  k8s_resource_limits = {
    cpu    = "0.5"
    memory = "512Mi"
  }
  k8s_resource_requests = {
    cpu    = "250m"
    memory = "50Mi"
  }
  k8s_container_port        = 80
  k8s_target_container_port = 80
  k8s_service_type          = "LoadBalancer"
}

module "cat_bucket" {
  source          = "./modules/cloud_storage"
  bucket_name     = "cat-bucket-22878"
  bucket_location = "US"
  object_name     = "cat.jpg"
  object_location = "./modules/cloud_storage/images/cat.jpg"
  is_public       = true
}

module "cat_bucket_lb" {
  source             = "./modules/bucket_lb"
  bucket_name        = module.cat_bucket.bucket_name
  backend_name       = "cat-bucket-backend"
  url_map_name       = "cat-bucket-url-map"
  load_balancer_name = "cat-bucket-lb"
}

module "gcp-sql" {
  source           = "./modules/sql"
  sql_name         = "terraform-instance"
  sql_version      = "MYSQL_5_7"
  sql_region       = "us-central1"
  sql_tier         = "db-n1-standard-1"
  sql_availability = "REGIONAL"
  sql_size         = 25
  sql_username     = "terraform"
  sql_password     = "password"
  sql_db           = "terraform"
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "./code"
  output_path = "./function.zip"
}

resource "google_storage_bucket" "upload_bucket" {
  name                        = "upload-22878"
  location                    = "US"
  uniform_bucket_level_access = true
  force_destroy               = true
  storage_class               = "STANDARD"
}

module "code_bucket" {
  source          = "./modules/cloud_storage"
  bucket_name     = "cloud-function-code-22878"
  bucket_location = "US"
  object_name     = "function.zip"
  object_location = data.archive_file.source.output_path
  is_public       = false

  depends_on = [
    google_storage_bucket.upload_bucket
  ]
}

resource "google_cloudfunctions_function" "function" {
  name    = "upload-trigger-22878"
  runtime = "python37"

  source_archive_bucket = module.code_bucket.bucket_name
  source_archive_object = module.code_bucket.object_name

  entry_point = "main"

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.upload_bucket.name
  }
}


resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret"

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

  secret_data = "secret-data"
}


