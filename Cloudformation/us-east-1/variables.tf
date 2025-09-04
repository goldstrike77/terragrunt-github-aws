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
      cloudformation = [
        {
          stack = [
            {
              name         = "create-cfn-stackset-exec-role"
              template_url = "https://s3.amazonaws.com/cloudformation-stackset-sample-templates-us-east-1/AWSCloudFormationStackSetExecutionRole.yml"
              parameters = {
                AdministratorAccountId = "315922616014"
              }
            }
          ]
        }
      ]
    }
  ]
}