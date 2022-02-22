/*
* GKE related resources (Cluster, Node pool, Nodes etc.)
* https://cloud.google.com/kubernetes-engine
*/

resource "google_service_account" "gke_service_account" {
  account_id   = "service-account-id"
  display_name = "Service Account (GKE)"
}

resource "google_container_cluster" "gke_cluster" {
  provider = google-beta

  name     = "homerating-ase-gke"
  location = local.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network = "homerating-vpc"
  subnetwork = "homerating-ase-subnet"
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {

  }
  
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "10.11.0.0/28"
  }

  addons_config {
      http_load_balancing {
        disabled = false
      }

    dns_cache_config {
      enabled = true 
    }
  }
}

resource "google_container_node_pool" "compute_node" {
  name       = "default-pool"
  location   = local.zone
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    service_account = google_service_account.gke_service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}