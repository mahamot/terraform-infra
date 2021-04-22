terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.0.0"
    }
  }
}

resource "scaleway_instance_security_group" "sg-ap" {
  inbound_default_policy  = "drop"
  
  inbound_rule {
    action = "accept"
    port   = "22"
  }

  inbound_rule {
    action = "accept"
    port   = "9090"
  }

  inbound_rule {
    action = "accept"
    port   = "9091"
  }

  inbound_rule {
    action = "accept"
    port   = "9093"
  }

  inbound_rule {
    action = "accept"
    port   = "3000"
  }

  inbound_rule {
    action = "accept"
    port   = "5601"
  }



}

output "security_group_id" {
  value = scaleway_instance_security_group.sg-ap.id
}
