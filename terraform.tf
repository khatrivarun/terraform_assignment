terraform {
  required_version = "1.3.3"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.15.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.43.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}
