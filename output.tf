/*Create a publically accessuble web page with Terraform.  You must complete the following
1) Terraform Script with a VPC
2) Terraform script must have a VM within your VPC.
3) The VM must have the homepage on it.
4) The VM must have an publically accessible link to it.
5) You must Git Push your script to your Github.
6) Output file must show 1) Public IP, 2) VPC, 3) Subnet of the VM, 4) Internal IP of the VM.
*/
# Output Information using your naming convention
output "app1_vpc_public_ip" {
  value = google_compute_instance.app1_instance.network_interface[0].access_config[0].nat_ip  # Assuming public IP is desired
}

output "app1_vpc_name" {
  value = google_compute_network.app1_vpc.name
}

output "pub_subnet_name" {
  value = google_compute_subnetwork.pub_subnet.name
}

output "vm_instance_internal_ip" {
  value = google_compute_instance.app1_instance.network_interface.0.network_ip
}

output "clickable_web_link" {
  value = format("http://%s", google_compute_instance.app1_instance.network_interface.0.access_config.0.nat_ip)
}

# Output with formatted URL
output "clickable_web_link2" {
  value = format("http://%s", google_compute_instance.app1_instance.network_interface.0.access_config.0.nat_ip)
}
