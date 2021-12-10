locals {
  vpc_id   = aws_vpc.this.id
  tag_name = join("-", [var.environment, var.project])
}

# create vpc(virtual private cloud)
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = join("-", [local.tag_name, "vpc"])

  }

}

//create internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = local.vpc_id

  tags = {
    "Name" = join("-", [local.tag_name, "internet_gateway"])
  }


}

//Create Elastic IP
resource "aws_eip" "this" {
  vpc = true

  tags = {
    "Name" = join("-", [local.tag_name, "elastic_ip"])
  }
}


//create Subnets

data "aws_availability_zones" "availability_zones" {
  state = "available"
}

variable "comman_tags" {
  default = ""
}

//create public subnet

resource "aws_subnet" "public" {

  count                   = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  availability_zone       = var.availability_zones_list[count.index]
  cidr_block              = var.public_subnets[count.index]
  vpc_id                  = local.vpc_id
  map_public_ip_on_launch = true

  tags = merge({
    Name = join("-", [local.tag_name, "public", "subnet"])
  }, var.common_tags, var.public_subnet_tags)

}


# create private subnet
resource "aws_subnet" "private" {

  count             = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  availability_zone = var.availability_zones_list[count.index]
  cidr_block        = var.private_subnets[count.index]
  vpc_id            = aws_vpc.vpc.id


  tags = merge({
    Name = join("-", [local.tag_name, "public", "subnet"])
  }, var.common_tags, var.public_subnet_tags)

}


# create NAT Gateway

resource "aws_nat_gateway" "public" {

  count         = length(var.public_subnets)
  allocation_id = "aws_eip.this[0].id"

  subnet_id = "aws_subnet.public.*.id"

  tags = {
    "Name" = join("-", [local.tag_name, "public_vpc_nat_gateway"])
  }

}



resource "aws_nat_gateway" "private" {
  connectivity_type = "private"
  subnet_id         = "aws_subnet.private.*.id"

  tags = {
    "Name" = join("-", [local.tag_name, "private_vpc_nat_gateway"])
  }

}


# Routing

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id
  route = {
    cidr_block = var.public_ip_address
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    "Name" = join("-", [local.tag_name, "rt"])
  }

}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets) > 0 ? var.public_subnets : 0
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table" "private" {
  vpc_id = local.vpc_id
  route = {
    cidr_block     = var.public_ip_address
    nat_gateway_id = aws_nat_gateway.private[0].id
  }

  tags = {
    Name = join("-", [local.tag_name, "rt"])
  }

}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets) > 0 ? var.private_subnets : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id

}
