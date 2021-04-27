output "db_ip_addr" {
  value = aws_db_instance.default.address
}

output "aws_secret_id" {
  value = aws_secretsmanager_secret.example.id
}

output "aws_secret_arn" {
  value = aws_secretsmanager_secret.example.arn
}