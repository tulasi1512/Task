provider "aws" {
region = "ap-south-1"
access_key = "AKIAYYNC2QLYVXI7VHKR"
secret_key ="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"
}
locals {
ingress_rules = [{
port = 22
description = "Ingress rules for port 22"
},
{
port = 80
description = "Ingress rules for port 80"
}]
}
resource "aws_instance" "terraform_ex" {
ami = "ami-01a4f99c4ac11b03c"
instance_type = "t2.micro"

tags = {
Name = "flm-instance"
}
vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
egress = [
{   
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    description      = ""
    prefix_list_ids   = []
    self           = false
    security_groups  = []
  }
]
dynamic "ingress" {
for_each = local.ingress_rules
content {
description = ingress.value.description
from_port  = ingress.value.port
to_port  = ingress.value.port
protocol  = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}
}
