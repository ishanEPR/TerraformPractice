provider "aws" {
   version = "~> 3.0"
   region  = var.region
   access_key = var.access_key
   secret_key = var.secret_key


  
}

# create vpc(virtual private cloud)
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"

    tags = {
      "Name" = "vpc"
      "Location"="Asia Pacific (Mumbai)"
    }
  
}

//create internet gateway
resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = "aws_vpc.vpc.id"

  tags = {
    "Name" = "vpc_internet_gateway"
  }

  
}

//Create Elastic IP
resource "aws_eip" "elastic_ip" {
  vpc = true
}


//create Subnets

data "aws_availability_zones" "availability_zones" {
  state = "available"
}

 //create public subnet

resource "aws_subnet" "public_subnets" {
   
  //  availability_zone = data.aws_availability_zones.availability_zones.names[0]

    count = length(var.public_subnets)
    availability_zone = var.availability_zones_list[count.index]
    cidr_block =var.public_subnets[count.index]
    vpc_id = "aws_vpc.vpc.id"
    map_public_ip_on_launch = true

    tags = {
      "Name" ="public_subnet-${count.index+1}"
    }
  
}


# create private subnet
resource "aws_subnet" "private_subnets" {
  
    count = length(var.private_subnets)
    # availability_zone = data.aws_availability_zones.availability_zones.names[0]
    availability_zone = var.availability_zones_list[count.index]
    cidr_block =var.private_subnets[count.index]
    vpc_id = "aws_vpc.vpc.id"
  

    tags = {
      "Name" ="private_subnet-${count.index+1}"
    }
  
}


# create NAT Gateway

resource "aws_nat_gateway" "public_vpc_nat_gateway" {

    count = length(var.public_subnets)
    allocation_id = "aws_eip.elastic_ip.id"
   // subnet_id = "aws_subnet.public_subnet_ap-south-1a.id"
   subnet_id = "aws_subnet.public_subnet-${count.index+1}.id"

    tags = {
      "Name" = "public_vpc_nat_gateway-${count.index+1}"
    }
  
}

# resource "aws_nat_gateway" "public_vpc_nat_gateway-1b" {

#     allocation_id = "aws_eip.elastic_ip.id"
#     subnet_id = "aws_subnet.public_subnet_ap-south-1b.id"

#     tags = {
#       "Name" = "public_vpc_nat_gateway-1b"
#     }
  
# }

resource "aws_nat_gateway" "private_vpc_nat_gateway" {
  connectivity_type = "private"
  # subnet_id = "aws_subnet.private_subnet_ap-south-1a.id"
   subnet_id = "aws_subnet.private_subnet-${count.index+1}.id"

}


# resource "aws_nat_gateway" "private_vpc_nat_gateway-1b" {
#   connectivity_type = "private"
#   subnet_id = "aws_subnet.private_subnet_ap-south-1b.id"

# }

# Routing

resource "aws_route_table" "vpc_public_route" {
    vpc_id = "aws_vpc.vpc.id"
    route = {
        cidr_block=var.public_ip_address
        gateway_id="aws_internet_gateway.vpc_internet_gateway.id"
    }

    tags = {
      "Name" = "vpc_public_route"
    }
  
}

resource "aws_default_route_table" "vpc_default_route" {

    default_route_table_id ="aws_vpc.vpc.default_route_table_id" 
    
    tags = {
      "Name" = "vpc_default_route"
    }

  
}
