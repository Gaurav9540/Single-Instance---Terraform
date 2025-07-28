provider "aws" {
  region = var.region 
}

# Data source to get default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get existing security group by name
data "aws_security_group" "existing_sg" {
  name   = var.aws_security_group   
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "example" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [data.aws_security_group.existing_sg.id]
  key_name                    = var.key_name

  tags = {
    Name = var.instance_name
  }
}
