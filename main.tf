resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

####################### KUBERNETES DEPLOYMENT ON GKE #######################

module "nginx_cluster" {
  source             = "./modules/google/gke_cluster"
  gke_cluster_name   = var.cluster_name
  gke_cluster_region = var.cluster_region
  gke_node_pool_name = var.cluster_node_pool_name
  gke_node_count     = var.cluster_node_count
}

data "google_client_config" "default" {}

module "k8s_nginx" {
  source                    = "./modules/google/kubernetes"
  gke_host                  = module.nginx_cluster.gke_host
  gke_token                 = data.google_client_config.default.access_token
  gke_ca_certificate        = module.nginx_cluster.gke_cluster_ca_certificate
  k8s_replicas              = var.k8s_replicas
  k8s_deployment_name       = var.k8s_deployment_name
  k8s_image                 = var.k8s_image
  k8s_resource_limits       = var.k8s_resource_limits
  k8s_resource_requests     = var.k8s_resource_requests
  k8s_container_port        = var.k8s_container_port
  k8s_target_container_port = var.k8s_target_container_port
  k8s_service_type          = var.k8s_service_type
}

####################### CLOUD SQL #######################

module "gcp-sql" {
  source           = "./modules/google/sql"
  sql_name         = var.sql_name
  sql_version      = var.sql_version
  sql_region       = var.sql_region
  sql_tier         = var.sql_tier
  sql_availability = var.sql_availability
  sql_size         = var.sql_size
  sql_username     = var.sql_username
  sql_password     = var.sql_password
  sql_db           = var.sql_db
}

####################### LOAD BALANCING GCS BUCKETS #######################

module "cat_bucket" {
  source          = "./modules/google/cloud_storage"
  bucket_name     = var.bucket_name
  bucket_location = var.bucket_location
  object_name     = var.object_name
  object_location = var.object_location
  is_public       = true
}

module "cat_bucket_lb" {
  source      = "./modules/google/bucket_lb"
  bucket_name = module.cat_bucket.bucket_name
}

####################### TRIGGERING CLOUD FUNCTIONS ON OBJECT FINALIZE ON GCS BUCKET #######################

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "./code"
  output_path = "./function.zip"
}

resource "google_storage_bucket" "upload_bucket" {
  name                        = "${var.upload_bucket_name}-${random_string.random.result}"
  location                    = var.upload_bucket_location
  uniform_bucket_level_access = true
  force_destroy               = true
  storage_class               = "STANDARD"
}

module "code_bucket" {
  source          = "./modules/google/cloud_storage"
  bucket_name     = var.code_bucket_name
  bucket_location = var.bucket_location
  object_name     = var.code_object_name
  object_location = data.archive_file.source.output_path
  is_public       = false

  depends_on = [
    google_storage_bucket.upload_bucket
  ]
}

resource "google_cloudfunctions_function" "function" {
  name    = "${var.cf_name}-${random_string.random.result}"
  runtime = "python37"

  source_archive_bucket = module.code_bucket.bucket_name
  source_archive_object = module.code_bucket.object_name

  entry_point = "main"

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.upload_bucket.name
  }
}

####################### GOOGLE SECRET MANAGER #######################

module "google_secret_manager" {
  source = "./modules/google/secret_manager"
  secret = "secret-data"
}

####################### HTTPS CONTENT BASED LOAD BALANCER #######################

module "vpc_network" {
  source = "./modules/google/network"
  region = var.gcp_region
}

data "template_file" "nginx_startup_script" {
  template = file("./nginx_script.sh")
}

data "template_file" "apache_startup_script" {
  template = file("./apache_script.sh")
}


module "nginx_managed_instance_group" {
  source         = "./modules/google/managed_instance_group"
  machine_type   = "e2-medium"
  source_image   = "debian-cloud/debian-11"
  network_name   = module.vpc_network.vpc_network_name
  subnet_name    = module.vpc_network.subnet_name
  startup_script = data.template_file.nginx_startup_script.rendered

  depends_on = [
    module.vpc_network
  ]
}

module "apache_managed_instance_group" {
  source         = "./modules/google/managed_instance_group"
  machine_type   = "e2-medium"
  source_image   = "debian-cloud/debian-11"
  network_name   = module.vpc_network.vpc_network_name
  subnet_name    = module.vpc_network.subnet_name
  startup_script = data.template_file.apache_startup_script.rendered

  depends_on = [
    module.vpc_network
  ]
}

module "nginx_http_proxy_backend_service" {
  source          = "./modules/google/managed_instance_group/backend_service"
  backend_mode    = "HTTP_PROXY"
  health_check_id = module.nginx_managed_instance_group.health_check_id
  instance_group  = module.nginx_managed_instance_group.instance_group
}

module "apache_http_proxy_backend_service" {
  source          = "./modules/google/managed_instance_group/backend_service"
  backend_mode    = "HTTP_PROXY"
  health_check_id = module.apache_managed_instance_group.health_check_id
  instance_group  = module.apache_managed_instance_group.instance_group
}

module "mig_load_balancer" {
  source             = "./modules/google/load_balancers/http_proxy"
  default_service_id = module.nginx_http_proxy_backend_service.backend_service_id
  path_rules = [
    {
      backend_service_id = module.apache_http_proxy_backend_service.backend_service_id
      path               = "/apache"
    },
    {
      backend_service_id = module.nginx_http_proxy_backend_service.backend_service_id
      path               = "/nginx"
    }
  ]

  depends_on = [
    module.apache_managed_instance_group,
    module.nginx_managed_instance_group
  ]
}

####################### MODULAR LOAD BALANCING #######################

#----------------- Kubernetes Ingress -----------------#

module "nginx_cluster" {
  source             = "./modules/google/gke_cluster"
  gke_cluster_name   = var.cluster_name
  gke_cluster_region = var.cluster_region
  gke_node_pool_name = var.cluster_node_pool_name
  gke_node_count     = var.cluster_node_count
}

data "google_client_config" "default" {}

module "k8s_nginx" {
  source                    = "./modules/google/kubernetes"
  gke_host                  = module.nginx_cluster.gke_host
  gke_token                 = data.google_client_config.default.access_token
  gke_ca_certificate        = module.nginx_cluster.gke_cluster_ca_certificate
  k8s_replicas              = var.k8s_replicas
  k8s_deployment_name       = var.k8s_deployment_name
  k8s_image                 = var.k8s_image
  k8s_resource_limits       = var.k8s_resource_limits
  k8s_resource_requests     = var.k8s_resource_requests
  k8s_container_port        = var.k8s_container_port
  k8s_target_container_port = var.k8s_target_container_port
  k8s_service_type          = "NodePort"
}

module "k8s_ingress" {
  source             = "./modules/google/kubernetes/v1/ingress"
  gke_host           = module.nginx_cluster.gke_host
  gke_token          = data.google_client_config.default.access_token
  gke_ca_certificate = module.nginx_cluster.gke_cluster_ca_certificate
  app_name           = var.k8s_deployment_name
  service_name       = module.k8s_nginx.service_name
  exposed_port       = var.k8s_target_container_port
  ingress_path       = "/nginx"
}

#----------------- Content Based Load Balancer -----------------#

module "vpc_network" {
  source = "./modules/google/network"
  region = var.gcp_region
}

data "template_file" "nginx_startup_script" {
  template = file("./nginx_script.sh")
}

module "nginx_managed_instance_group" {
  source         = "./modules/google/managed_instance_group"
  machine_type   = "e2-medium"
  source_image   = "debian-cloud/debian-11"
  network_name   = module.vpc_network.vpc_network_name
  subnet_name    = module.vpc_network.subnet_name
  startup_script = data.template_file.nginx_startup_script.rendered

  depends_on = [
    module.vpc_network
  ]
}

module "http_external_backend_service" {
  source          = "./modules/google/managed_instance_group/backend_service"
  backend_mode    = "HTTP_EXTERNAL"
  health_check_id = module.nginx_managed_instance_group.health_check_id
  instance_group  = module.nginx_managed_instance_group.instance_group
}

module "http_mig_load_balancer" {
  source     = "./modules/google/load_balancers/http"
  service_id = module.http_external_backend_service.backend_service_id
}

#----------------- TCP External Load Balancer -----------------#

module "vpc_network" {
  source = "./modules/google/network"
  region = var.gcp_region
}

data "template_file" "nginx_startup_script" {
  template = file("./nginx_script.sh")
}

module "nginx_managed_instance_group" {
  source         = "./modules/google/managed_instance_group"
  machine_type   = "e2-medium"
  source_image   = "debian-cloud/debian-11"
  network_name   = module.vpc_network.vpc_network_name
  subnet_name    = module.vpc_network.subnet_name
  startup_script = data.template_file.nginx_startup_script.rendered

  depends_on = [
    module.vpc_network
  ]
}

module "tcp_external_backend_service" {
  source          = "./modules/google/managed_instance_group/backend_service"
  backend_mode    = "TCP_EXTERNAL"
  health_check_id = module.nginx_managed_instance_group.health_check_id
  instance_group  = module.nginx_managed_instance_group.instance_group
}

module "tcp_load_balancer" {
  source             = "./modules/google/load_balancers/tcp"
  backend_service_id = module.tcp_external_backend_service.backend_service_id
  mode               = "EXTERNAL"
  port_range         = "80"
}

#----------------- TCP Internal Load Balancer -----------------#

module "vpc_network" {
  source = "./modules/google/network"
  region = var.gcp_region
}

data "template_file" "nginx_startup_script" {
  template = file("./nginx_script.sh")
}

module "nginx_managed_instance_group" {
  source         = "./modules/google/managed_instance_group"
  machine_type   = "e2-medium"
  source_image   = "debian-cloud/debian-11"
  network_name   = module.vpc_network.vpc_network_name
  subnet_name    = module.vpc_network.subnet_name
  startup_script = data.template_file.nginx_startup_script.rendered

  depends_on = [
    module.vpc_network
  ]
}

module "tcp_internal_backend_service" {
  source          = "./modules/google/managed_instance_group/backend_service"
  backend_mode    = "TCP_INTERNAL"
  health_check_id = module.nginx_managed_instance_group.health_check_id
  instance_group  = module.nginx_managed_instance_group.instance_group
}

module "tcp_load_balancer" {
  source             = "./modules/google/load_balancers/tcp"
  backend_service_id = module.tcp_internal_backend_service.backend_service_id
  mode               = "INTERNAL"
  port_range         = "80"
  network            = module.vpc_network.vpc_network_name
  subnetwork         = module.vpc_network.subnet_name
}

####################### VPN BETWEEN GCP AND AWS #######################

module "google_custom_vpc" {
  source        = "./modules/google/network"
  ip_cidr_range = "10.1.1.0/24"
}

module "google_ha_vpn" {
  source  = "./modules/google/network/vpn"
  network = module.google_custom_vpc.vpc_network_name
}

module "google_cloud_router" {
  source  = "./modules/google/network/cloud_router"
  network = module.google_custom_vpc.vpc_network_name
}

module "aws_vpc" {
  source = "./modules/aws/vpc"
}

module "aws_customer_gateways" {
  source            = "./modules/aws/network/customer_gateway"
  google_asn        = module.google_cloud_router.bgp_asn
  google_interfaces = module.google_ha_vpn.public_ip_interfaces
}

module "aws_vpn_gateway" {
  source         = "./modules/aws/network/vpn_gateway"
  vpc_id         = module.aws_vpc.vpc_id
  cgw_interfaces = module.aws_customer_gateways.cgw_interfaces
}

module "google_external_gateway" {
  source      = "./modules/google/external_gateway"
  cgw_tunnels = module.aws_vpn_gateway.cgw_tunnels
}

module "google_vpn_tunnels" {
  source              = "./modules/google/vpn_tunnels"
  vpn_gateway_id      = module.google_ha_vpn.vpn_gateway
  router_url          = module.google_cloud_router.url
  external_gateway_id = module.google_external_gateway.external_gateway_id
  cgw_shared_secrets  = module.aws_vpn_gateway.cgw_shared_secrets
}

module "google_router_interfaces" {
  source                 = "./modules/google/network/cloud_router/interfaces"
  cgw_internal_ip_ranges = module.aws_vpn_gateway.cgw_internal_ip_ranges
  tunnels                = module.google_vpn_tunnels.tunnels
  vgw_internal_ips       = module.aws_vpn_gateway.vgw_internal_ips
  cgw_bgp_asns           = module.aws_vpn_gateway.cgw_bgp_asns
  router                 = module.google_cloud_router.url
}
