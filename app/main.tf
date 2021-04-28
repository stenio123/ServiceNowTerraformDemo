# reference to module
/**module "db" {
  source = "../terraform_aws_db_module"
}
module "db-module" {
  source  = "app.terraform.io/TFE_PoV/db-module/aws"
  version = "2.0.0"
}*/

# depends_on is a fix for terraform <0.12 which reads data before references by default
data "aws_secretsmanager_secret_version" "example" {
  secret_id = var.aws_secret_id
  #depends_on = [module.db-module.aws_secret_id]
}




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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  user_data = <<-EOF
		#! /bin/bash
        echo  ${data.aws_secretsmanager_secret_version.example.secret_string} > /home/ubuntu/secret.txt
        echo  ${var.db_ip_addr} > /home/ubuntu/url.txt
	EOF
  tags = {
    Name = "Stenio"
  }
}