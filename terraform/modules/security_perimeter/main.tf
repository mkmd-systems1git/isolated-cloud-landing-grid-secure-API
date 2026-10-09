# Provision an isolated virtual cloud network for perimeter containment
resource "aws_vpc" "secure_network" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "isolated-perimeter-network"
    ManagedBy   = "Terraform-IaC"
  }
}

# Engineer an edge network firewall to control incoming data traffic loops
resource "aws_security_group" "perimeter_firewall" {
  name        = "secure-edge-firewall"
  description = "Enforce isolation rules for incoming enterprise data streams"
  vpc_id      = aws_vpc.secure_network.id

  # Inbound Rule: Allow secure MQTT/API streaming metrics strictly on Port 1883
  ingress {
    description = "Allow secure ingestion inputs from active remote edge nodes"
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In production, this is restricted to specific fleet/office IP ranges
  }

  # Outbound Rule: Allow data synchronization out to our cloud databases
  egress {
    description = "Allow processed logs to route securely out to the storage vault"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Export the isolated VPC ID so it can be read by the master control cockpit
output "network_id" {
  value = aws_vpc.secure_network.id
}
