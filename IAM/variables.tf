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
      account = [
        {
          password_policy = [
            {
              allow_users_to_change_password = true
            }
          ]
        }
      ]
    }
  ]
}
