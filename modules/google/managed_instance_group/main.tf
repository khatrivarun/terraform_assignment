resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "google_compute_instance_template" "instance_template" {
  name         = "instance-template-${random_string.random.result}"
  machine_type = var.machine_type

  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name
  }

  metadata_startup_script = var.startup_script
}

resource "google_compute_http_health_check" "vm_health_check" {
  name               = "vm-health-check-${random_string.random.result}"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_instance_group_manager" "managed_instance_group" {
  name = "managed-instance-group-${random_string.random.result}"

  base_instance_name = "managed-instance-group-vm"

  version {
    instance_template = google_compute_instance_template.instance_template.id
  }

  target_size = 2

  auto_healing_policies {
    health_check      = google_compute_http_health_check.vm_health_check.id
    initial_delay_sec = 60
  }
}
