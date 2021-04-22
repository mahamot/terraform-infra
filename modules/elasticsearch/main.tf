terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.0.0"
    }
  }
}

resource "scaleway_instance_security_group" "sg-es" {
  inbound_default_policy  = "drop"
  
  inbound_rule {
    action = "accept"
    port   = "22"
  }
}

output "security_group_id" {
  value = scaleway_instance_security_group.sg-es.id
}
