data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*-26.04-amd64-server-*"]
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "ubuntu" {
  for_each               = local.ec2_instances
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value
  key_name               = aws_key_pair.ssh-macbook-keys.key_name
  vpc_security_group_ids = [aws_security_group.sg-ssh-allow.id]

  tags = {
    Name = each.key
  }
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.sg-ssh-allow.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.sg-ssh-allow.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "sg-ssh-allow" {
  name        = "tf-ubuntu-sg"
  description = "SSH to EC2"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_key_pair" "ssh-macbook-keys" {
  key_name   = "tf-ubuntu-keys"
  public_key = var.public_key
}

output "public_ips" {
  value = { for k, v in aws_instance.ubuntu : k => v.public_ip }
}