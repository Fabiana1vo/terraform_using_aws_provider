terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

data "aws_secretsmanager_secret" "secret" {
  arn = "arn:aws:secretsmanager:us-east-2:825765413912:secret:prod/Terraform/Db-x7M2ln"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secret.id
}

## Criando uma VPC -> 
resource "aws_vpc" "exemple" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_route_table" "exemple_route_table" {
  vpc_id = aws_vpc.exemple.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.exemple_igw.id
  }
}
resource "aws_route_table_association" "exemple_route_table_association" {
  subnet_id      = aws_subnet.exemple_subnet.id
  route_table_id = aws_route_table.exemple_route_table.id
}
resource "aws_security_group" "exemple_sg" {
  vpc_id = aws_vpc.exemple.id
  name   = "Allow SSH"

  tags = {
    Name = "Allow SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "exemple_sg_ingress_rule" {
  security_group_id = aws_security_group.exemple_sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}



resource "aws_subnet" "exemple_subnet" {
  vpc_id            = aws_vpc.exemple.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
}



resource "aws_instance" "exemple_instance" {
  ami                    = "ami-0eb9d6fc9fab44d24"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.exemple_subnet.id
  vpc_security_group_ids = [aws_security_group.exemple_sg.id]
  user_data              = <<EOF
#!/bin/bash
DB_STRING="Server=${jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["Host"]};DB=${jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["Username"]};"
echo $DB_STRING > test.txt
EOF 
}


resource "aws_internet_gateway" "exemple_igw" {
  vpc_id = aws_vpc.exemple.id
}

resource "aws_eip" "exemple_ipestatico" {
  instance   = aws_instance.exemple_instance.id
  depends_on = [aws_internet_gateway.exemple_igw]
}

resource "aws_ssm_parameter" "parameter" {
  name  = "vm_ip"
  type  = "String"
  value = aws_eip.exemple_ipestatico.public_ip
}

output "private_dns" {
  value = aws_instance.exemple_instance.private_dns
}

output "eip" {
  value = aws_eip.exemple_ipestatico.public_ip
}
