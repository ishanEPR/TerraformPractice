locals {

  tag_name = join("-", [var.environment, var.project])
}

# create EC2 instances 
resource "aws_instance" "web" {

  count         = length(var.private_subnets)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(aws_subnet.private.*.id, count.index)

  tags = {
    Name = join("-", [local.tag_name, "ec2"])
  }
}