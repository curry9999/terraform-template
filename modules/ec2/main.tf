data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "main" {
  filter {
    name   = "tag:Name"
    values = ["mac"]
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "handson_public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "routetable"
  }
}

resource "aws_route_table_association" "handson_public_rt_associate" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.handson_public_rt.id
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone

  tags = {
    Name = "subnet"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id       = aws_subnet.my_subnet.id
  private_ips     = var.network_interface_ips
  security_groups = [aws_security_group.handson_ec2_sg.id]

  tags = {
    Name = "primary_network_interface"
  }
}

data "http" "ifconfig" {
  url    = "http://ipv4.icanhazip.com/"
  method = "GET"
}

locals {
  myip         = chomp(data.http.ifconfig.response_body)
  allowed_cidr = "${local.myip}/32"
}

resource "aws_security_group" "handson_ec2_sg" {
  name        = "terraform-handson-ec2-sg"
  description = "For EC2 Linux"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "vpc-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "foo" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.ec2_instance_type
  key_name                    = data.aws_key_pair.main.key_name
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = [aws_security_group.handson_ec2_sg.id]
  associate_public_ip_address = "true"

  credit_specification {
    cpu_credits = "unlimited"
  }
}
