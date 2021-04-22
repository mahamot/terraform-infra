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
  count      = var.num_instance
  type       = "b_ssd"
  size_in_gb = var.data_disk_size
}

resource "scaleway_instance_ip" "public_ip" {
  count = var.num_instance
}

#resource "scaleway_vpc_private_network" "pn_priv" {
#    name = "subnet_jb"
#}

resource "scaleway_instance_server" "instance" {
  count                 = var.num_instance
  type                  = "${count.index}" == 4 ? "DEV1-XL": var.type_server
  image                 = "ubuntu_focal"
  name                  = "jeremie-${count.index}"
  ip_id                 = scaleway_instance_ip.public_ip[count.index].id
  additional_volume_ids = [scaleway_instance_volume.volume[count.index].id]
  security_group_id     = "${count.index}" == 4 ?  module.sg-ap.sg_id : module.sg-es.sg_id 
}


module "sg-es" {
  source = "./modules/elasticsearch"
}

module "sg-ap" {
  source = "./modules/applications"
}

#resource "scaleway_instance_private_nic" "pnic01" {
#    server_id          = "fr-par-1/11111111-1111-1111-1111-111111111111"
#    private_network_id = "fr-par-1/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
#}


