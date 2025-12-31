locals {
  env = terraform.workspace
}

resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.keypair

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>This is ${local.env} environment</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name        = var.instance_name
    Environment = terraform.workspace
  }
}

