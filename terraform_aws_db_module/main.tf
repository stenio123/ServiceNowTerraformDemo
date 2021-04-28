resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "foo"
  password             = random_string.random_secret.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

resource "random_string" "random_secret" {
  length           = 16
  special          = false
  upper = true
  lower = true
  #override_special = "/@£$"
}

# It is best to have dynamic secret name because otherwise if secret is deleted, 
# it stays in 'scheduled for deletion' for a while in AWS, potentially causing naming clash if destroy followed by apply.
resource "random_string" "random_secret_name" {
  length           = 4
  special          = false
  upper = true
  lower = true
}

resource "aws_secretsmanager_secret" "example" {
  name = "db_${random_string.random_secret_name.result}"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = random_string.random_secret.result
  depends_on = [aws_secretsmanager_secret.example]
}