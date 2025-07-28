provider "aws" {
  region = "ap-south-1" 
}

# Data source to get default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get existing security group by name
data "aws_security_group" "existing_sg" {
  name   = "my-sg"   
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "example" {
  ami                         = "ami-0f918f7e67a3323f0"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_vpc.default.subnets[0] 
  vpc_security_group_ids      = [data.aws_security_group.existing_sg.id]
  key_name                    = "new-key"

  tags = {
    Name = "Instance-1"
  }
}
