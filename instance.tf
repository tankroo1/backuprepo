/*Create a publically accessuble web page with Terraform.  You must complete the following
1) Terraform Script with a VPC
2) Terraform script must have a VM within your VPC.
3) The VM must have the homepage on it.
4) The VM must have an publically accessible link to it.
5) You must Git Push your script to your Github.
6) Output file must show 1) Public IP, 2) VPC, 3) Subnet of the VM, 4) Internal IP of the VM.
*/

resource "google_compute_instance" "app1_instance" {
  name         = "europe-instance"
  machine_type = "n2-standard-2"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
      auto_delete = true
  }

  network_interface {
    network    = google_compute_network.app1_vpc.name
    subnetwork = google_compute_subnetwork.pub_subnet.name

access_config {
      // Ephemeral public IP
    }

}
  tags = ["http-server"]

 metadata = {
    metadata_startup_script = file("${path.module}/startup-script.sh")
  }
}  
