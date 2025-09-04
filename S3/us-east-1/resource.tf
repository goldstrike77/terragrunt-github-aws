# 账户的S3屏蔽公共访问权限设置
module "aws_s3_account_public_access_block" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//s3/account-public-access-block?ref=v6.x"
  aws_resources = var.aws_resources
}