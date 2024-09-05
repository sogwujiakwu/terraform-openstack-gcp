# Data block to fetch available machine types in a specific zone
data "google_compute_zones" "available_zones" {}

data "google_compute_machine_types" "vm_type" {
  for_each = toset(data.google_compute_zones.available_zones.names)

  filter = "name = \"n1-standard-4\"" # e.g., "n1-standard-1"
  zone   = each.value
}

# Output to show the availability of the machine type
output "available_vm_types" {
  value = {
    for zone, vm_type in data.google_compute_machine_types.vm_type : zone => vm_type.machine_types[0].self_link
  }
}

output "unavailable_zones" {
  value = [
    for zone in data.google_compute_zones.available_zones.names :
    zone if zone != lookup({ for k, v in data.google_compute_machine_types.vm_type : k => k }, zone, null)
  ]
}

