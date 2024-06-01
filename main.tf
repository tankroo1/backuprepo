/*Create a publically accessuble web page with Terraform.  You must complete the following
1) Terraform Script with a VPC
2) Terraform script must have a VM within your VPC.
3) The VM must have the homepage on it.
4) The VM must have an publically accessible link to it.
5) You must Git Push your script to your Github.
6) Output file must show 1) Public IP, 2) VPC, 3) Subnet of the VM, 4) Internal IP of the VM.
*/
# VPC and Subnetwork for Europe Headquarters
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.28.0"
    }
  }
}

provider "google" {
  # Configuration options
  region = "us-central1"
  project =  "viceroygunray"
  zone = "us-central1-a"
  credentials = "viceroygunray-712c1dbcf854.json"
}

resource "google_compute_network" "app1_vpc" {
  name                     = "hawkheaven-vpc"
  auto_create_subnetworks  =  false
  routing_mode             = "REGIONAL"
  mtu                      = 1460
}

resource "google_compute_subnetwork" "pub_subnet" {
  name          = "moonstarburst-sub-1"
  ip_cidr_range = "10.110.10.0/24"
  region        = "europe-west1"
  network       = google_compute_network.app1_vpc.self_link
  }

# Firewall Rule to Allow Port 80 Traffic to Europe

resource "google_compute_firewall" "allow_port_80_traffic" {
  project = "viceroygunray"
  name    = "allow-port-80-traffic"
  network = google_compute_network.app1_vpc.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22", "80", "3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

