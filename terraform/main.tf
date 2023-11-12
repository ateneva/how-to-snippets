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

resource "google_storage_bucket" "gcp_geeking" {
  name     = "gcp_geeking"
  location = "EU"
}