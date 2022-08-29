provider "aws" {
  region = "eu-west-1"
}

resource "aws_lightsail_key_pair" "main_key_pair" {
  name       = "main_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_lightsail_instance" "server-ls" {
  name              = "server-ls"
  availability_zone = "eu-west-1b"
  blueprint_id      = "ubuntu"
  bundle_id         = "small_2_0"
  key_pair_name     = aws_lightsail_key_pair.main_key_pair.name
  tags = {
    "Env"    = "Dev"
    
  }
}

resource "aws_lightsail_instance_public_ports" "server-ls" {
  instance_name = aws_lightsail_instance.server-ls.name

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
}

output "instance_id" {
  value = aws_lightsail_instance.server-ls.id
}

output "instance_arn" {
  value = aws_lightsail_instance.server-ls.arn
}

output "created_at" {
  value = aws_lightsail_instance.server-ls.created_at
}





