terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.44.1"
    }
  }
}

provider "google-beta" {
  region  = "asia-northeast1"
  project = "angular-yeti-368200"
}

data "google_project" "project" {
  provider = google-beta
}

resource "google_compute_network" "default" {
  provider = google-beta
  name     = "alloydb-cluster"
}

resource "google_alloydb_cluster" "default" {
  provider   = google-beta
  cluster_id = "alloydb-cluster"
  location   = "asia-northeast1"
  network    = "projects/${data.google_project.project.number}/global/networks/${google_compute_network.default.name}"

  initial_user {
    password = "alloydb-cluster"
  }
}

resource "google_compute_global_address" "private_ip_alloc" {
  provider      = google-beta
  name          = "alloydb-cluster"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 16
  network       = google_compute_network.default.id
}

resource "google_service_networking_connection" "vpc_connection" {
  provider                = google-beta
  network                 = google_compute_network.default.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}
