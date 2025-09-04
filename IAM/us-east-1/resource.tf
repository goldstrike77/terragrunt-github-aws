# 账户别名
module "aws_iam_account_alias" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/account-alias?ref=v6.x"
  aws_resources = var.aws_resources
}

# 角色
module "aws_iam_role" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/role?ref=v6.x"
  aws_resources = var.aws_resources
  tags          = var.tags
}

# 角色策略
module "aws_iam_role_policy" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/role-policy?ref=v6.x"
  aws_resources = var.aws_resources
  depends_on    = [module.aws_iam_role]
}

# 角色策略挂载
module "aws_iam_role_policy_attachment" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/role-policy-attachment?ref=v6.x"
  aws_resources = var.aws_resources
  depends_on    = [module.aws_iam_role]
}
