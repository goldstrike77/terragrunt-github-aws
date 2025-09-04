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
      s3 = [
        {
          account_public_access_block = [
            {
              block_public_acls       = true
              block_public_policy     = true
              ignore_public_acls      = true
              restrict_public_buckets = true
            }
          ]
        }
      ]
    }
  ]
}
