provider "vault" {
  address = var.vault_url
  auth_login {
    path = "auth/userpass/login/${var.vault_username}"

    parameters = {
      password = var.vault_userpass
    }
  }
}

data "vault_generic_secret" "db_secret" {
  path = var.vault_secret_path
}


data "vault_aws_access_credentials" "creds" {
  backend = var.vault_aws_secret_path
  role    = var.vault_aws_role
}

provider "aws" {
  access_key = "${data.vault_aws_access_credentials.creds.access_key}"
  secret_key = "${data.vault_aws_access_credentials.creds.secret_key}"
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
  instance_type = "t2.micro"
  user_data = <<-EOF
		#! /bin/bash
        echo  ${data.vault_generic_secret.db_secret.data_json} > /home/ubuntu/secret.txt
        echo  ${var.db_ip_addr} > /home/ubuntu/url.txt
	EOF
  tags = {
    Name = "Stenio2"
  }
}
