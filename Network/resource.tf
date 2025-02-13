# 虚拟私有云
module "aws_vpc" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
}

# DHCP选项集
module "aws_vpc_dhcp_options" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/dhcp-options?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
}

# DHCP选项集关联
module "aws_vpc_dhcp_options_association" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/dhcp-options/association?ref=v5.x"
  aws_resources = var.aws_resources
  depends_on    = [module.aws_vpc, module.aws_vpc_dhcp_options]
}

# 子网
module "aws_subnet" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/subnet?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on    = [module.aws_vpc_dhcp_options_association]
}
