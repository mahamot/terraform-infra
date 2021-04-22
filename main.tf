terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.0.0"
    }
  }
}

provider "scaleway" {}

resource "scaleway_instance_volume" "volume" {
  type       = "b_ssd"
  size_in_gb = var.data_disk_size
}

resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_server" "instance" {
  count                 = var.num_instance
  type                  = ${count.index} == 4 ? "DEV1-XL": var.type_server
  image                 = "ubuntu_focal"
  name                  = "jeremie-${count.index}"
  ip_id                 = scaleway_instance_ip.public_ip.id
  additional_volume_ids = [scaleway_instance_volume.data.id]
}




