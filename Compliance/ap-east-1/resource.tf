# 存储桶
module "aws_s3_bucket" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//s3/bucket?ref=v6.x"
  tags          = var.tags
  aws_resources = var.aws_resources
}

# 存储桶策略
module "aws_s3_bucket_policy" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//s3/bucket-policy?ref=v6.x"
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_s3_bucket
  ]
}

# 账户活动
module "aws_cloudtrail" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//cloudtrail?ref=v6.x"
  aws_resources = var.aws_resources
  tags          = var.tags
  depends_on = [
    module.aws_s3_bucket_policy
  ]
}

# 账户的S3屏蔽公共访问权限设置
module "aws_s3_account_public_access_block" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//s3/account-public-access-block?ref=v6.x"
  aws_resources = var.aws_resources
}

# 账户的EBS加密设置
module "aws_ebs_encryption_by_default" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//ebs/encryption-by-default?ref=v6.x"
  aws_resources = var.aws_resources
}

# 账户和工作负载的智能威胁防护设置
module "aws_guardduty_detector" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//guardduty/detector?ref=v6.x"
  tags          = var.tags
  aws_resources = var.aws_resources
}
