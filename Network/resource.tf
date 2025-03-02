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
  depends_on = [
    module.aws_vpc,
    module.aws_vpc_dhcp_options
  ]
}

# 子网
module "aws_subnet" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/subnet?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_vpc_dhcp_options_association
  ]
}

# 中转网关
module "aws_ec2_transit_gateway" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//transit-gateway?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_subnet
  ]
}

# 中转网关挂载
module "aws_ec2_transit_gateway_vpc_attachment" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//transit-gateway/vpc-attachment?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_ec2_transit_gateway
  ]
}

# 中转网关路由表
module "aws_ec2_transit_gateway_route_table" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//transit-gateway/route-table?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_ec2_transit_gateway_vpc_attachment
  ]
}

# 互联网网关
module "aws_internet_gateway" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/internet-gateway?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_vpc
  ]
}

# 弹性IP
module "aws_eip" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//ec2/eip?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
}

# NAT网关
module "aws_nat_gateway" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/nat-gateway?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_eip,
    module.aws_internet_gateway,
    module.aws_subnet
  ]
}

# 路由表
module "aws_route_table" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/route-table?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_vpc,
    module.aws_internet_gateway,
    module.aws_subnet,
    module.aws_nat_gateway,
    module.aws_ec2_transit_gateway_route_table
  ]
}

# 安全组
module "aws_security_group" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/security-group?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_vpc
  ]
}

# 访问控制管理角色
module "aws_iam_role" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/role?ref=v5.x"
  tags          = var.tags
  aws_resources = var.aws_resources
}

# 访问控制管理策略
module "aws_iam_role_policy" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//iam/role-policy?ref=v5.x"
  aws_resources = var.aws_resources
  depends_on = [
    module.aws_iam_role
  ]
}

# 日志组
module "aws_cloudwatch_log_group" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//cloudwatch/log-group?ref=v5.x"
  aws_resources = var.aws_resources
  tags          = var.tags
}

# 流日志
module "aws_flow_log" {
  source        = "git::https://github.com/goldstrike77/terraform-module-aws.git//vpc/flow-log?ref=v5.x"
  aws_resources = var.aws_resources
  tags          = var.tags
  depends_on = [
    module.aws_iam_role,
    module.aws_cloudwatch_log_group
  ]
}
