resource "aws_vpc" "shop_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "shop_subnets" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.shop_vpc.id
  cidr_block        = element(var.subnet_cidrs, count.index)
}

