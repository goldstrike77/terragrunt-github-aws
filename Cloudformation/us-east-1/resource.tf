# 堆栈
module "aws_cloudformation_stack" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//cloudformation/stack?ref=v6.x"
  aws_resources = var.aws_resources
  tags          = var.tags
}