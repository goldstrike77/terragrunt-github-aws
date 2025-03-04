# 存储桶
module "aws_s3_bucket" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//s3/bucket?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
}

# 存储桶策略
module "aws_s3_bucket_policy" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//s3/bucket-policy?ref=v5.x"
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_s3_bucket
  ]
}

# 账户活动
module "aws_cloudtrail" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//cloudtrail?ref=v5.x"
  aws_resources = var.aws_resources
  tags          = var.tags
  depends_on = [
    module.aws_s3_bucket_policy
  ]
}
