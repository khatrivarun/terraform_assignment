gcp_project            = "second-modem-369610"
gcp_region             = "us-east1"
gcp_zone               = "us-east1-b"
cluster_name           = "nginx-cluster"
cluster_region         = "us-east1"
cluster_node_pool_name = "nginx-node-pool"
cluster_node_count     = 1
k8s_replicas           = 1
k8s_deployment_name    = "nginx-deployment"
k8s_image              = "nginx"
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
bucket_name               = "cat-bucket"
bucket_location           = "US"
object_name               = "cat.jpg"
object_location           = "./modules/cloud_storage/images/cat.jpg"
sql_name                  = "random"
sql_version               = "MYSQL_5_7"
sql_region                = "us-east1"
sql_tier                  = "db-n1-standard-1"
sql_availability          = "REGIONAL"
sql_size                  = 63
sql_username              = "terraform"
sql_password              = "password"
sql_db                    = "terraformdb"
upload_bucket_name        = "upload"
upload_bucket_location    = "US"
code_bucket_name          = "code"
code_object_name          = "code"
cf_name                   = "upload-trigger"