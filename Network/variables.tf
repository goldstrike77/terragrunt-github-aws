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
              cidr_block = "10.50.0.0/24"
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
        }
      ],
      vpc_dhcp_options = [
        {
          vpc = ["vpc-ap-east-1-01", "vpc-ap-east-1-02"]
          tags = {
            Name = "dopt-vpc-ap-east-1-01"
          }
        }
      ]
    }
  ]
}
