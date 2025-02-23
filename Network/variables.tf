variable "tags" {
  default = {
    location    = "ap-east-1"
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
            Name = "vpc-ap-east-1-egress-01"
          }
          subnet = [
            {
              availability_zone = "ap-east-1a"
              cidr_block        = "10.50.0.0/24"
              tags = {
                Name = "subnet-vpc-ap-east-1-egress-01-01"
              }
            },
            {
              availability_zone = "ap-east-1a"
              cidr_block        = "10.50.1.0/24"
              tags = {
                Name = "subnet-vpc-ap-east-1-egress-01-02"
              }
            }
          ]
        },
        {
          cidr_block = "10.51.0.0/16"
          tags = {
            Name = "vpc-ap-east-1-app-01"
          }
          subnet = [
            {
              availability_zone = "ap-east-1a"
              cidr_block        = "10.51.0.0/24"
              tags = {
                Name = "subnet-vpc-ap-east-1-app-01-01"
              }
            },
            {
              availability_zone = "ap-east-1a"
              cidr_block        = "10.51.1.0/24"
              tags = {
                Name = "subnet-vpc-ap-east-1-app-01-02"
              }
            }
          ]
        },
        {
          cidr_block = "10.52.0.0/16"
          tags = {
            Name = "vpc-ap-east-1-app-02"
          }
          subnet = [
            {
              availability_zone = "ap-east-1a"
              cidr_block        = "10.52.0.0/24"
              tags = {
                Name = "subnet-vpc-ap-east-1-app-02-01"
              }
            },
            {
              availability_zone = "ap-east-1a"
              cidr_block        = "10.52.1.0/24"
              tags = {
                Name = "subnet-vpc-ap-east-1-app-02-02"
              }
            }
          ]
        }
      ],
      vpc_dhcp_options = [
        {
          vpc = ["vpc-ap-east-1-egress-01", "vpc-ap-east-1-app-01", "vpc-ap-east-1-app-02"]
          tags = {
            Name = "dopt-vpc-ap-east-1-01"
          }
        }
      ],
      #vpc_peering_connection = [
      #  {
      #    vpc      = "vpc-ap-east-1-egress-01"
      #    peer_vpc = "vpc-ap-east-1-app-01"
      #    tags = {
      #      Name = "pcx-vpc-ap-east-1-egress-01-vpc-ap-east-1-app-01"
      #    }
      #  },
      #  {
      #    vpc      = "vpc-ap-east-1-egress-01"
      #    peer_vpc = "vpc-ap-east-1-app-02"
      #    tags = {
      #      Name = "pcx-vpc-ap-east-1-egress-01-vpc-ap-east-1-app-02"
      #    }
      #  }
      #],
      internet_gateway = [
        {
          vpc = "vpc-ap-east-1-egress-01"
          tags = {
            Name = "igw-vpc-ap-east-1-egress-01"
          }
        }
      ],
      eip = [
        {
          tags = {
            Name = "eipalloc-ap-east-1-egress-01"
          }
        }
      ],
      nat_gateway = [
        {
          allocation = "eipalloc-ap-east-1-egress-01"
          private_ip = "10.50.0.10"
          subnet     = "subnet-vpc-ap-east-1-egress-01-01"
          tags = {
            Name = "nat-ap-east-1-egress-01"
          }
        }
      ],
      route_table = [
        {
          vpc = "vpc-ap-east-1-egress-01"
          tags = {
            Name = "rtb-vpc-ap-east-1-egress-01-01"
          }
          route = [
            { cidr_block = "0.0.0.0/0", gateway = "igw-vpc-ap-east-1-egress-01" },
            { cidr_block = "10.51.0.0/16", transit_gateway = "tgw-ap-east-1-hub-01" },
            { cidr_block = "10.52.0.0/16", transit_gateway = "tgw-ap-east-1-hub-01" },
            #            { cidr_block = "10.51.0.0/16", vpc_peering_connection = "pcx-vpc-ap-east-1-egress-01-vpc-ap-east-1-app-01" },
            #            { cidr_block = "10.52.0.0/16", vpc_peering_connection = "pcx-vpc-ap-east-1-egress-01-vpc-ap-east-1-app-02" }
          ]
          subnet = ["subnet-vpc-ap-east-1-egress-01-01"]
        },
        {
          vpc = "vpc-ap-east-1-egress-01"
          tags = {
            Name = "rtb-vpc-ap-east-1-egress-01-02"
          }
          route = [
            { cidr_block = "0.0.0.0/0", nat_gateway = "nat-ap-east-1-egress-01" },
            { cidr_block = "10.51.0.0/16", transit_gateway = "tgw-ap-east-1-hub-01" },
            { cidr_block = "10.52.0.0/16", transit_gateway = "tgw-ap-east-1-hub-01" },
            #            { cidr_block = "10.51.0.0/16", vpc_peering_connection = "pcx-vpc-ap-east-1-egress-01-vpc-ap-east-1-app-01" },
            #            { cidr_block = "10.52.0.0/16", vpc_peering_connection = "pcx-vpc-ap-east-1-egress-01-vpc-ap-east-1-app-02" }
          ]
          subnet = ["subnet-vpc-ap-east-1-egress-01-02"]
        },
        {
          vpc = "vpc-ap-east-1-app-01"
          tags = {
            Name = "rtb-vpc-ap-east-1-app-01"
          }
          route = [
            { cidr_block = "0.0.0.0/0", transit_gateway = "tgw-ap-east-1-hub-01" }
          ]
          subnet = ["subnet-vpc-ap-east-1-app-01-01", "subnet-vpc-ap-east-1-app-01-02"]
        },
        {
          vpc = "vpc-ap-east-1-app-02"
          tags = {
            Name = "rtb-vpc-ap-east-1-app-02"
          }
          route = [
            { cidr_block = "0.0.0.0/0", transit_gateway = "tgw-ap-east-1-hub-01" }
          ]
          subnet = ["subnet-vpc-ap-east-1-app-02-01", "subnet-vpc-ap-east-1-app-02-02"]
        }
      ],
      transit_gateway = [
        {
          #          default_route_table_association = "disable"
          #          default_route_table_propagation = "disable"
          tags = {
            Name = "tgw-ap-east-1-hub-01"
          },
          vpc_attachment = [
            {
              vpc    = "vpc-ap-east-1-egress-01"
              subnet = "subnet-vpc-ap-east-1-egress-01-01"
              tags = {
                Name = "tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-egress-01"
              }
            },
            {
              vpc    = "vpc-ap-east-1-app-01"
              subnet = "subnet-vpc-ap-east-1-app-01-01"
              tags = {
                Name = "tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-app-01"
              }
            },
            {
              vpc    = "vpc-ap-east-1-app-02"
              subnet = "subnet-vpc-ap-east-1-app-02-01"
              tags = {
                Name = "tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-app-02"
              }
            }
          ],
          route_table = [
            {
              tags = {
                Name = "tgw-rtb-ap-east-1-hub-01"
              }
              route = [
                { destination_cidr_block = "0.0.0.0/0", blackhole = false, transit_gateway_attachment = "tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-egress-01" }
              ]
              #association = ["tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-app-01", "tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-app-02"]
              propagation = ["tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-app-01", "tgw-attach-tgw-ap-east-1-hub-01-vpc-ap-east-1-app-02"]
            }
          ]
        }
      ]
    }
  ]
}
