# 账户设置
module "aws_iam_account_password_policy" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/account-password-policy?ref=v5.x"
  aws_resources = var.aws_resources
}

# 用户
module "aws_iam_user" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/user?ref=v5.x"
  aws_resources = var.aws_resources
  tags          = var.tags
}
output "aws_iam_user_password" {
  value     = module.aws_iam_user.aws_iam_user_password
  sensitive = true
}

# 用户组
module "aws_iam_group" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/group?ref=v5.x"
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_iam_user
  ]
}
