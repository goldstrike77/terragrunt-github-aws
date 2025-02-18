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
            Name = "vpc-ap-east-1-01"
          }
          subnet = [
            {
              availability_zone = "ap-east-1a"
              cidr_block        = "10.50.0.0/24"
              tags = {
                Name = "subnet-vpc-ap-east-1-01"
              }
            }
          ]
        },
        {
          cidr_block = "10.51.0.0/16"
          tags = {
            Name = "vpc-ap-east-1-02"
          }
        },
        {
          cidr_block = "10.52.0.0/16"
          tags = {
            Name = "vpc-ap-east-1-03"
          }
        }
      ],
      vpc_dhcp_options = [
        {
          vpc = ["vpc-ap-east-1-01", "vpc-ap-east-1-02", "vpc-ap-east-1-03"]
          tags = {
            Name = "dopt-vpc-ap-east-1-01"
          }
        }
      ],
      vpc_peering_connection = [
        {
          vpc      = "vpc-ap-east-1-01"
          peer_vpc = "vpc-ap-east-1-02"
          tags = {
            Name = "pcx-vpc-ap-east-1-01-vpc-ap-east-1-02"
          }
        },
        {
          vpc      = "vpc-ap-east-1-01"
          peer_vpc = "vpc-ap-east-1-03"
          tags = {
            Name = "pcx-vpc-ap-east-1-01-vpc-ap-east-1-03"
          }
        }
      ],
      internet_gateway = [
        {
          vpc = "vpc-ap-east-1-01"
          tags = {
            Name = "igw-vpc-ap-east-1-01"
          }
        }
      ],
      eip = [
        {
          tags = {
            Name = "eipalloc-ap-east-1-01"
          }
        }
      ],
      nat_gateway = [
        {
          allocation = "eipalloc-ap-east-1-01"
          private_ip = "10.50.0.10"
          subnet     = "subnet-vpc-ap-east-1-01"
          tags = {
            Name = "nat-ap-east-1-01"
          }
        }
      ]
    }
  ]
}
