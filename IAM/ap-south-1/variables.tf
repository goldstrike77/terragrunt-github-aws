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
      user = [
        {
          name          = "jackiechen"
          force_destroy = true
        },
        {
          name          = "tomwong"
          force_destroy = true
        },
        {
          name          = "samliu"
          force_destroy = true
        }
      ]
      group = [
        {
          name              = "admin"
          user              = ["jackiechen"]
          policy_attachment = ["AdministratorAccess"]
        },
        {
          name              = "developer"
          user              = ["tomwong", "samliu"]
          policy_attachment = ["AmazonVPCFullAccess", "AmazonEC2FullAccess"]
        }
      ]
    }
  ]
}
