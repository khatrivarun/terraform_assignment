resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.bucket_location

  uniform_bucket_level_access = true
  force_destroy               = true
  storage_class               = "STANDARD"
}

resource "google_storage_bucket_iam_member" "bucket_iam" {
  count  = var.is_public ? 1 : 0
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_object" "object" {
  name   = var.object_name
  source = var.object_location
  bucket = google_storage_bucket.bucket.name
}
