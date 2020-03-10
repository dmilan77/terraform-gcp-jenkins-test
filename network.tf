provider "google" {
  version = "3.5.0"

  

  project = "jenkins-on-kubernetes-01"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
