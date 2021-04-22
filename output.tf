output "instance_address" {
  value = scaleway_instance_ip.public_ip[*].id
}
