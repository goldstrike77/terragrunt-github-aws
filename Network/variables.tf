variable "tags" {
  default = {
    location    = "ap-south-1"
    environment = "prd"
    customer    = "Learn"
    owner       = "Somebody"
    email       = "somebody@mail.com"
    title       = "Engineer"
    department  = "IS"
  }
}

variable "aws_resources" {
  default = [
    {
      vpc = [
        {
          cidr_block = "10.50.0.0/16"
          tags = {
            Name = "vpc-ap-south-1-egress-01"
          }
          enable_dns_hostnames = true
          subnet = [
            {
              availability_zone = "ap-south-1a"
              cidr_block        = "10.50.0.0/27"
              tags = {
                Name = "subnet-vpc-ap-south-1-egress-01-01"
              }
            },
            {
              availability_zone = "ap-south-1a"
              cidr_block        = "10.50.0.32/27"
              tags = {
                Name = "subnet-vpc-ap-south-1-egress-01-02"
              }
            },
            {
              availability_zone = "ap-south-1b"
              cidr_block        = "10.50.0.64/27"
              tags = {
                Name = "subnet-vpc-ap-south-1-egress-01-03"
              }
            },
            {
              availability_zone = "ap-south-1b"
              cidr_block        = "10.50.0.96/27"
              tags = {
                Name = "subnet-vpc-ap-south-1-egress-01-04"
              }
            }
          ]
        },
        {
          cidr_block = "10.51.0.0/16"
          tags = {
            Name = "vpc-ap-south-1-app-01"
          }
          enable_dns_hostnames = true
          subnet = [
            {
              availability_zone = "ap-south-1a"
              cidr_block        = "10.51.0.0/24"
              tags = {
                Name = "subnet-vpc-ap-south-1-app-01-01"
              }
            },
            {
              availability_zone = "ap-south-1a"
              cidr_block        = "10.51.1.0/24"
              tags = {
                Name = "subnet-vpc-ap-south-1-app-01-02"
              }
            }
          ]
        },
        {
          cidr_block = "10.52.0.0/16"
          tags = {
            Name = "vpc-ap-south-1-app-02"
          }
          enable_dns_hostnames = true
          subnet = [
            {
              availability_zone = "ap-south-1a"
              cidr_block        = "10.52.0.0/24"
              tags = {
                Name = "subnet-vpc-ap-south-1-app-02-01"
              }
            },
            {
              availability_zone = "ap-south-1a"
              cidr_block        = "10.52.1.0/24"
              tags = {
                Name = "subnet-vpc-ap-south-1-app-02-02"
              }
            }
          ]
        }
      ],
      vpc_dhcp_options = [
        {
          vpc = ["vpc-ap-south-1-egress-01", "vpc-ap-south-1-app-01", "vpc-ap-south-1-app-02"]
          tags = {
            Name = "dopt-vpc-ap-south-1-01"
          }
        }
      ],
      internet_gateway = [
        {
          vpc = "vpc-ap-south-1-egress-01"
          tags = {
            Name = "igw-vpc-ap-south-1-egress-01"
          }
        }
      ],
      eip = [
        {
          tags = {
            Name = "eipalloc-ap-south-1-egress-01"
          }
        },
        {
          tags = {
            Name = "eipalloc-ap-south-1-egress-02"
          }
        }
      ],
      nat_gateway = [
        {
          allocation = "eipalloc-ap-south-1-egress-01"
          subnet     = "subnet-vpc-ap-south-1-egress-01-01"
          tags = {
            Name = "nat-ap-south-1-egress-01"
          }
        },
        {
          allocation = "eipalloc-ap-south-1-egress-02"
          subnet     = "subnet-vpc-ap-south-1-egress-01-03"
          tags = {
            Name = "nat-ap-south-1-egress-02"
          }
        }
      ],
      route_table = [
        {
          vpc = "vpc-ap-south-1-egress-01"
          tags = {
            Name = "rtb-vpc-ap-south-1-egress-01-01"
          }
          route = [
            { cidr_block = "0.0.0.0/0", gateway = "igw-vpc-ap-south-1-egress-01" },
            { cidr_block = "10.51.0.0/16", transit_gateway = "tgw-ap-south-1-hub-01" },
            { cidr_block = "10.52.0.0/16", transit_gateway = "tgw-ap-south-1-hub-01" }
          ]
          subnet = ["subnet-vpc-ap-south-1-egress-01-01", "subnet-vpc-ap-south-1-egress-01-03"]
        },
        {
          vpc = "vpc-ap-south-1-egress-01"
          tags = {
            Name = "rtb-vpc-ap-south-1-egress-01-02"
          }
          route = [
            { cidr_block = "0.0.0.0/0", nat_gateway = "nat-ap-south-1-egress-01" }
          ]
          subnet = ["subnet-vpc-ap-south-1-egress-01-02"]
        },
        {
          vpc = "vpc-ap-south-1-egress-01"
          tags = {
            Name = "rtb-vpc-ap-south-1-egress-01-03"
          }
          route = [
            { cidr_block = "0.0.0.0/0", nat_gateway = "nat-ap-south-1-egress-02" }
          ]
          subnet = ["subnet-vpc-ap-south-1-egress-01-04"]
        },
        {
          vpc = "vpc-ap-south-1-app-01"
          tags = {
            Name = "rtb-vpc-ap-south-1-app-01"
          }
          route = [
            { cidr_block = "0.0.0.0/0", transit_gateway = "tgw-ap-south-1-hub-01" }
          ]
          subnet = ["subnet-vpc-ap-south-1-app-01-01", "subnet-vpc-ap-south-1-app-01-02"]
        },
        {
          vpc = "vpc-ap-south-1-app-02"
          tags = {
            Name = "rtb-vpc-ap-south-1-app-02"
          }
          route = [
            { cidr_block = "0.0.0.0/0", transit_gateway = "tgw-ap-south-1-hub-01" }
          ]
          subnet = ["subnet-vpc-ap-south-1-app-02-01", "subnet-vpc-ap-south-1-app-02-02"]
        }
      ],
      transit_gateway = [
        {
          auto_accept_shared_attachments  = "enable"
          default_route_table_association = "disable"
          default_route_table_propagation = "disable"
          tags = {
            Name = "tgw-ap-south-1-hub-01"
          },
          vpc_attachment = [
            {
              vpc    = "vpc-ap-south-1-egress-01"
              subnet = ["subnet-vpc-ap-south-1-egress-01-02", "subnet-vpc-ap-south-1-egress-01-04"]
              tags = {
                Name = "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-egress-01"
              }
              transit_gateway_default_route_table_association = false
              transit_gateway_default_route_table_propagation = false
            },
            {
              vpc    = "vpc-ap-south-1-app-01"
              subnet = ["subnet-vpc-ap-south-1-app-01-01"]
              tags = {
                Name = "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-01"
              }
              transit_gateway_default_route_table_association = false
              transit_gateway_default_route_table_propagation = false
            },
            {
              vpc    = "vpc-ap-south-1-app-02"
              subnet = ["subnet-vpc-ap-south-1-app-02-01"]
              tags = {
                Name = "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-02"
              }
              transit_gateway_default_route_table_association = false
              transit_gateway_default_route_table_propagation = false
            }
          ],
          route_table = [
            {
              tags = {
                Name = "tgw-rtb-ap-south-1-hub-01"
              }
              route = [
                { destination_cidr_block = "0.0.0.0/0", blackhole = false, transit_gateway_attachment = "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-egress-01" },
                { destination_cidr_block = "192.168.0.0/16", blackhole = true },
                { destination_cidr_block = "172.16.0.0/12", blackhole = true },
                { destination_cidr_block = "10.0.0.0/8", blackhole = true }
              ]
              association = ["tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-01", "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-02"]
              propagation = ["tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-01", "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-02"]
            },
            {
              tags = {
                Name = "tgw-rtb-ap-south-1-hub-02"
              }
              route = [
                { destination_cidr_block = "10.51.0.0/16", blackhole = false, transit_gateway_attachment = "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-01" },
                { destination_cidr_block = "10.52.0.0/16", blackhole = false, transit_gateway_attachment = "tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-app-02" }
              ]
              association = ["tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-egress-01"]
              propagation = ["tgw-attach-tgw-ap-south-1-hub-01-vpc-ap-south-1-egress-01"]
            }
          ]
        }
      ],
      security_group = [
        {
          tags = {
            Name = "sg-vpc-ap-south-1-egress-01"
          },
          vpc = "vpc-ap-south-1-egress-01"
          rule = [
            { from_port = 8, protocol = "icmp", to_port = 0, type = "ingress", cidr_blocks = ["0.0.0.0/0"], description = "Allow ICMP ping requests." },
            { from_port = 0, protocol = "tcp", to_port = 22, type = "ingress", cidr_blocks = ["10.50.0.0/16"], description = "Allow SSH requests." },
            { from_port = 0, protocol = "-1", to_port = 0, type = "egress", cidr_blocks = ["0.0.0.0/0"], description = "Allow all egress." }
          ]
        },
        {
          tags = {
            Name = "sg-vpc-ap-south-1-app-01-01"
          },
          vpc = "vpc-ap-south-1-app-01"
          rule = [
            { from_port = 8, protocol = "icmp", to_port = 0, type = "ingress", cidr_blocks = ["0.0.0.0/0"], description = "Allow ICMP ping requests." },
            { from_port = 0, protocol = "tcp", to_port = 22, type = "ingress", cidr_blocks = ["10.50.0.0/16"], description = "Allow SSH requests." },
            { from_port = 0, protocol = "-1", to_port = 0, type = "egress", cidr_blocks = ["0.0.0.0/0"], description = "Allow all egress." }
          ]
        },
        {
          tags = {
            Name = "sg-vpc-ap-south-1-app-02-01"
          },
          vpc = "vpc-ap-south-1-app-02"
          rule = [
            { from_port = 8, protocol = "icmp", to_port = 0, type = "ingress", cidr_blocks = ["0.0.0.0/0"], description = "Allow ICMP ping requests." },
            { from_port = 0, protocol = "tcp", to_port = 22, type = "ingress", cidr_blocks = ["10.50.0.0/16"], description = "Allow SSH requests." },
            { from_port = 0, protocol = "-1", to_port = 0, type = "egress", cidr_blocks = ["0.0.0.0/0"], description = "Allow all egress." }
          ]
        }
      ]
    }
  ]
}
