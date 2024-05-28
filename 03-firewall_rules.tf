# -------------------------------------------------------------- #
# FIREWALL-RULES
# -------------------------------------------------------------- #
# https://stackoverflow.com/questions/68776789/terraform-data-google-compute-network-not-working

resource "google_compute_firewall" "allow-source-health-check" {
  name      = "${var.corelightfw_name}-rule-allow-health-chk"
  project   = var.gcp_project_id
  network   = google_compute_network.regovpc.self_link
  #network   = data.google_compute_network.collectorvpc.self_link
  #network   = google_compute_network.main.name
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  depends_on    = [google_compute_subnetwork.regosubnet]
}

# ALLOW THE CORELIGHT IDS SENSORS OUTBOUND TO ALL PROTOCOLS
resource "google_compute_firewall" "allow_source_egress" {
  # for_each  = toset(local.same_project_mirror_networks)
  name      = "${var.corelightfw_name}-rule-allow-egress"
  project   = var.gcp_project_id
  network   = google_compute_network.regovpc.self_link
  direction = "EGRESS"
  allow {
    protocol = "all"
  }
  #destination_ranges = ["10.2.0.0/16"]   SOURCE NETWORK CIDR
  destination_ranges = [var.collector_network_cidr]
 depends_on    = [google_compute_subnetwork.regosubnet]
}

# ALLOW THE CORELIGHT IDS SENSORS TO RECEIVE ALL TRAFFIC FROM ALL SOURCES
resource "google_compute_firewall" "allow_source_ingress" {
  name      = "${var.corelightfw_name}-rule-allowsrc-ingress"
  project   = var.gcp_project_id
  network   = google_compute_network.regovpc.self_link
  #network   = data.google_compute_network.collectorvpc.self_link
  #network   = google_compute_network.regovpc.name
  direction = "INGRESS"
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.corelight_ids_firewall_tags
  depends_on    = [google_compute_subnetwork.regosubnet]
}

# ALLOW THE SPLUNK SERVER TO RECEIVE TRAFFIC FROM ALL SOURCES USING TARGET NETWORK TAGS
resource "google_compute_firewall" "allow_splunkaccess_ingress" {
  name      = "${var.corelightfw_name}-rule-splunkaccess-ingress"
  project   = var.gcp_project_id
  network   = google_compute_network.regovpc.self_link
  #network   = data.google_compute_network.collectorvpc.self_link
  #network   = google_compute_network.main.name
  direction = "INGRESS"
    allow {
        protocol = "tcp"
        ports = var.splunkports
    }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.splunk_server_tags
  depends_on    = [google_compute_subnetwork.regosubnet]
}

# ALLOW THE SPLUNK SERVER TO RECEIVE TRAFFIC FROM ALL SOURCES USING TARGET NETWORK TAGS
resource "google_compute_firewall" "allow_elkserveraccess_ingress" {
  name      = "${var.corelightfw_name}-rule-elkstack-ingress"
  project   = var.gcp_project_id
  network   = google_compute_network.regovpc.self_link
  #network   = data.google_compute_network.collectorvpc.self_link
  #network   = google_compute_network.main.name
  direction = "INGRESS"
    allow {
        protocol = "tcp"
        ports = var.elkports
    }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.elk_server_tags
  depends_on    = [google_compute_subnetwork.regosubnet]
}



# ALLOW GOOGLE CLOUD IAP - TCP \ ICMP
resource "google_compute_firewall" "allow_iap_ingress" {
  name      = "${var.corelightfw_name}-rule-allowiap-ingress"
  project   = var.gcp_project_id
  network   = google_compute_network.regovpc.self_link
  #network   = data.google_compute_network.collectorvpc.self_link
  #network   = google_compute_network.main.name
  direction = "INGRESS"
  allow {
    protocol = "icmp"
  }
    allow {
        protocol = "tcp"
        ports = [
            "22" # Server SSH
        ]
    }
  source_ranges = ["35.235.240.0/20"]
  depends_on    = [google_compute_subnetwork.regosubnet]
}


# resource "google_compute_route" "egress_internet" {
#   name             = "egress-internet"
#   dest_range       = "0.0.0.0/0"
#   network          = google_compute_network.vpc.name
#   next_hop_gateway = "default-internet-gateway"
# }