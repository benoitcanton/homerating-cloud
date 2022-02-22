terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.11.0"
    }
  }
}

provider "google" {
  credentials = file("credentials.json")
  project = local.project
  region = local.region
  zone = local.zone
}

provider "google-beta" {
  credentials = file("credentials.json")
  project = local.project
  region = local.region
  zone = local.zone
}
