/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# -------------------------------------------------------------- #
# PROJECT variables
# -------------------------------------------------------------- #
# variable "credentials" {
#   description = "Path to a service account credentials file with rights to run the Google Zeek Automation. If this file is absent Terraform will fall back to Application Default Credentials."
#   type        = string
#   default     = ""
# }

# variable "gcp_project" {
#   description = "GCP Project Id"
#   type        = string
# }

variable "gcp_project_id" {
  description = "GCP Project Id"
  type        = string
  default = "development-337317"
}

variable "source_machine_tags" {
  description = "Mirror VPC Tags list to be mirrored."
  type        = list(string)
  default     = []
}

variable "corelight_ids_firewall_tags" {
  description = "Mirror VPC Tags list to be mirrored."
  type        = list(string)
  default     = []
}


variable "elk_server_tags" {
  description = "Mirror VPC Tags list to be mirrored."
  type        = list(string)
  default     = []
}

variable "splunk_server_tags" {
  description = "Mirror VPC Tags list to be mirrored."
  type        = list(string)
  default     = []
}

variable "splunkports" {
  type        = list(string)
  default     = []
}

variable "elkports" {
  type        = list(string)
  default     = []
}
# ---

# -------------------------------------------------------------- #
# VPC NETWORK 1 - module variables
# -------------------------------------------------------------- #
variable "source_vpc_name" {
  description = "Portion of name to be generated for the VPC network."
  type        = string
  default = "rego-vpc-demo"
}

variable "source_subnet_name" {
  description = "Portion of name to be generated for the Subnet network."
  type        = string
  default = "rego-subnet-demo"
}

variable "network_cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "Network CIDR"
}

variable "collector_network_cidr" {
  type        = string
  default     = "10.2.0.0/16"
  description = "Collector Corelight Sensors Network CIDR"
}

variable "source_subnet4_name" {
  description = "Portion of name to be generated for the Subnet network."
  type        = string
  default = "rego-subnet4-demo"
}

variable "subnet4_network_cidr" {
  type        = string
  default     = "10.20.0.0/24"
  description = "Collector Corelight Sensors Network CIDR"
}

variable "corelightfw_name" {
  type        = string
  default     = "rego-fw-rule"
  description = "Firwall name prefix"
}

variable "region" {
  type        = string
  default     = "europe-west2"
  description = "Region to create resources"
}
variable "zone" {
  type        = string
  default     = "europe-west2-a"
  description = "Region to create resources"
}

# -------------------------------------------------------------- #
# VPC COLLECTOR MIRROR NETWORK 2 - module variables
# -------------------------------------------------------------- #
variable "network" {
  type        = string
  default     = "col"
  description = "Collector Corelight Sensors Network CIDR"
}
# variable "collector_vpc_name" {
#   description = "Portion of name to be generated for the VPC network."
#   type        = string
# }

# variable "collector_subnet_name" {
#   description = "Portion of name to be generated for the VPC network."
#   type        = string
# }


# p u b l i c    s u b n e t  - For Source VM GCP instance

variable "public_subnet_name" {
  description = "Portion of name to be generated for the VPC network."
  type        = string
  default = "rego-pub-subnet"
}

# variable "public_subnet_selflink" {
#   description = "Portion of name to be generated for the VPC network gotten from outputs"
#   type        = string
# }

variable "public_subnet_cidr" {
  type        = string
  default     = "10.20.2.0/24"
  description = "Network CIDR"
}

# - - - - 

# variable "collect_mirror_network_selflink" {
#   description = "Direct self link in the GCP project id network selflink resource api"
#   type        = string
# }

# variable "collect_mirror_subnet_selflink" {
#   description = "Direct self link in the GCP project id subnet selflink resource api"
#   type        = string
# }

variable "vpc_description" {
  description = "The description of the VPC Network."
  type        = string
  default     = "This is collector VPC network."
}

variable "vpc_routing_mode" {
  description = "Routing mode of the VPC. A 'GLOBAL' routing mode can have adverse impacts on load balancers. Prefer 'REGIONAL'."
  type        = string
  default     = "REGIONAL"
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  type        = bool
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  type        = bool
  default     = false
}

variable "mtu" {
  description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
  type        = number
  default     = 0
}

variable "private_ip_google_access" {
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
  type        = bool
  default     = true
}

# variable "subnets" {
#   type = list(object({
#     mirror_vpc_network          = string
#     collector_vpc_subnet_cidr   = string
#     collector_vpc_subnet_region = string
#   }))
#   description = "The list of subnets being created"
# }
# -------------------------------------------------------------- #
# VPC-PEERING module variables
# -------------------------------------------------------------- #

# variable "export_peer_custom_routes" {
#   description = "Export custom routes to local network from peer network."
#   type        = bool
#   default     = false
# }

# variable "export_local_custom_routes" {
#   description = "Export custom routes to peer network from local network."
#   type        = bool
#   default     = false
# }

# PEERING NAMES

# variable "shared_host_project_peering_selflink" {
#   description = "Portion of name to be generated for the VPC network."
#   type        = string
# }

# variable "source_peering_name" {
#   description = "Portion of name to be generated for the VPC network."
#   type        = string
# }

# variable "dest_peering_name" {
#   description = "Portion of name to be generated for the VPC network."
#   type        = string
# }

# ---
# -------------------------------------------------------------- #
# CORELIGHT PACKET MIRROR VARIABLES
# -------------------------------------------------------------- #

# packer_mirror_name    = "corelight_packer_mirror"
# backend_service_name  = "packetmirror_backend_service"
# backend_healthcheck_name = "packetmirror_backend_healthcheck"
# policy_forwarding_rule_name = "corelight_policy_fwd_2_ilb"
# autoscaler_name              =   "corelight_zeek_autoscaler"
# corelight_template_name = "corelight_instance_template_demo"
# corelight_mgmt_group_name = "corelight_mgmtgroup_demo"


# variable "collector_vpc_mirror_subnet" {
#   description = "Direct API address to collector-vpc-subnet"
#   type        = map(list(string))
# }

# =======