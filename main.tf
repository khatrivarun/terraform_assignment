provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

provider "google-beta" {
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

# module "vpc_network" {
#   source = "./modules/network"
#   region = var.gcp_region
# }

# data "template_file" "nginx_startup_script" {
#   template = file("./nginx_script.sh")
# }

# data "template_file" "apache_startup_script" {
#   template = file("./apache_script.sh")
# }


# module "nginx_managed_instance_group" {
#   source         = "./modules/managed_instance_group"
#   machine_type   = "e2-medium"
#   source_image   = "debian-cloud/debian-11"
#   network_name   = module.vpc_network.vpc_network_name
#   subnet_name    = module.vpc_network.subnet_name
#   startup_script = data.template_file.nginx_startup_script.rendered

#   depends_on = [
#     module.vpc_network
#   ]
# }

# module "apache_managed_instance_group" {
#   source         = "./modules/managed_instance_group"
#   machine_type   = "e2-medium"
#   source_image   = "debian-cloud/debian-11"
#   network_name   = module.vpc_network.vpc_network_name
#   subnet_name    = module.vpc_network.subnet_name
#   startup_script = data.template_file.apache_startup_script.rendered

#   depends_on = [
#     module.vpc_network
#   ]
# }

# module "mig_load_balancer" {
#   source             = "./modules/load_balancers/http_proxy"
#   default_service_id = module.nginx_managed_instance_group.backend_service_id
#   path_rules = [
#     {
#       backend_service_id = module.apache_managed_instance_group.backend_service_id
#       path               = "/apache"
#     },
#     {
#       backend_service_id = module.nginx_managed_instance_group.backend_service_id
#       path               = "/nginx"
#     }
#   ]

#   depends_on = [
#     module.apache_managed_instance_group,
#     module.nginx_managed_instance_group
#   ]
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
#   k8s_service_type          = "NodePort"
# }

# module "k8s_ingress" {
#   source             = "./modules/kubernetes/v1/ingress"
#   gke_host           = module.nginx_cluster.gke_host
#   gke_token          = data.google_client_config.default.access_token
#   gke_ca_certificate = module.nginx_cluster.gke_cluster_ca_certificate
#   app_name           = var.k8s_deployment_name
#   service_name       = module.k8s_nginx.service_name
#   exposed_port       = var.k8s_target_container_port
#   ingress_path       = "/nginx"
# }

module "vpc_network" {
  source = "./modules/network"
  region = var.gcp_region
}

data "template_file" "nginx_startup_script" {
  template = file("./nginx_script.sh")
}

data "template_file" "apache_startup_script" {
  template = file("./apache_script.sh")
}

module "nginx_managed_instance_group" {
  source         = "./modules/managed_instance_group"
  machine_type   = "e2-medium"
  source_image   = "debian-cloud/debian-11"
  network_name   = module.vpc_network.vpc_network_name
  subnet_name    = module.vpc_network.subnet_name
  startup_script = data.template_file.nginx_startup_script.rendered

  depends_on = [
    module.vpc_network
  ]
}

# module "http_mig_load_balancer" {
#   source     = "./modules/load_balancers/http"
#   service_id = module.nginx_managed_instance_group.backend_service_id
# }
