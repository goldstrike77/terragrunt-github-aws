# 账户设置
module "aws_iam_account_password_policy" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/account-password-policy?ref=v5.x"
  aws_resources = var.aws_resources
}
