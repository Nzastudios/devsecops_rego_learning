# -------------------------------------------------------------- #
# VPC - SOURCE Network and Subnet
# -------------------------------------------------------------- #
# source_vpc_name = "source-origin-vpc"
# source_subnet_name = "source-origin-subnet"

resource "google_compute_network" "regovpc" {
  name                            = var.source_vpc_name
  project                         = var.gcp_project_id
  routing_mode                    = var.vpc_routing_mode
  description                     = var.vpc_description
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = var.delete_default_internet_gateway_routes
  mtu                             = var.mtu
}


resource "google_compute_subnetwork" "regosubnet" {
  # for_each                 = local.collector_vpc_subnets
  name                     = var.source_subnet_name
  project                  = var.gcp_project_id
  ip_cidr_range            = var.network_cidr
  region                   = var.region
  private_ip_google_access = var.private_ip_google_access
  network                  = google_compute_network.regovpc.id
  #depends_on               = [google_compute_network.default]
}


# -------------------------------------------------------------- #
# PUBLIC SUBNET NO. 3  SOURCE GCP INSTANCE HERE
# -------------------------------------------------------------- #

# PUBLIC SUBNET 
# FOR Source WEB SERVER VM using blank access config block for PUBLIC IP ADDRESS
resource "google_compute_subnetwork" "public_subnet" {
  name          = var.public_subnet_name
  project       = var.gcp_project_id
  ip_cidr_range = var.public_subnet_cidr
  network       = google_compute_network.regovpc.id #deploy public subnet in COLLECTOR MIRROR NETWORK - MUST BE SAME NETWORK AS COLLECTOR for SourceVM instance traffic forwarded by FORWARDING RULE
  region        = var.region
  #depends_on    = [google_compute_network.regovpc]
}

# -------------------------------------------------------------- #
# PRIVATE SUBNET NO. 4  SOURCE MIRROR SUBNET
# -------------------------------------------------------------- #
resource "google_compute_subnetwork" "subnet4" {
  # for_each               = local.collector_vpc_subnets
  name                     = var.source_subnet4_name
  project                  = var.gcp_project_id
  ip_cidr_range            = var.subnet4_network_cidr
  region                   = var.region
  private_ip_google_access = var.private_ip_google_access
  network                  = google_compute_network.regovpc.self_link
  depends_on               = [google_compute_network.regovpc]
}