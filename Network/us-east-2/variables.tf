variable "tags" {
  default = {
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
        }
      ]
    }
  ]
}
