/*
* Network related resources (VPC, Subnet, Router, Cloud NAT etc.)
*/

resource "google_compute_network" "vpc_network" {
  name = "homerating-vpc"
  mtu = 1460
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "homerating-ase-subnet"
  ip_cidr_range = "10.10.0.0/16"
  region        = local.region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_compute_router" "nat_router" {
  name    = "homerating-ase-router"
  region  = google_compute_subnetwork.vpc_subnet.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "homerating-ase-nat"
  router                             = google_compute_router.nat_router.name
  region                             = google_compute_router.nat_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}