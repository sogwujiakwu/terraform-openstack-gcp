variable "zone" {
  default = "us-east1-c"
}

resource "google_compute_instance" "openstack_controller" {
  name         = "openstack-controller"
  machine_type = "n1-standard-4"
  zone         = var.zone
  tags         = ["http-server", "https-server", "novnc", "openstack-apis"]
  boot_disk {
    initialize_params {
      size  = 200
      image = "nested-vm-image"
    }
  }
  can_ip_forward = true
  network_interface {
    network = google_compute_network.openstack_vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_instance" "openstack_compute" {
  name         = "openstack-compute"
  machine_type = "n1-standard-4"
  zone         = var.zone
  tags         = ["http-server", "https-server", "novnc", "openstack-apis"]
  boot_disk {
    initialize_params {
      size = 200
      image = "nested-vm-image"
    }
  }
  can_ip_forward = true
  network_interface {
    network = google_compute_network.openstack_vpc_network.name
    access_config {
    }
  }
}
