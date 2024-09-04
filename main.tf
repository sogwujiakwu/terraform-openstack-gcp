terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = "smart-nomad-433514-k5"
}

resource "google_compute_network" "openstack_vpc_network" {
  name = "openstack-network"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "n1-standard-4"
  zone         = "us-central1-b"
  boot_disk {
    initialize_params {
      image = "nested-vm-image"
    }
  }

  network_interface {
    network = google_compute_network.openstack_vpc_network.name
    access_config {
    }
  }
}

