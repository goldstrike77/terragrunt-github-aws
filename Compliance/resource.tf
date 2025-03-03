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
