terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "data-geeking-gcp"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_storage_bucket" "eu-data-challenge" {
  name          = "eu-data-challenge"
  location      = "EU"
  storage_class = "STANDARD"
  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
  force_destroy = true

  retention_policy {
    retention_period = 2592000
  }
}

resource "google_storage_bucket" "eu-data-books" {
  name          = "eu-data-books"
  location      = "europe-west1"
  storage_class = "ARCHIVE"
  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
  force_destroy = true
}


resource "google_bigquery_dataset" "the-data-challenge" {
  dataset_id                  = "the_data_challenge"
  friendly_name               = "the-data-challenge"
  description                 = "This dataset stores the data-engineering challenge"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}