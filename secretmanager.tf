data "aws_secretsmanager_secret" "secrets" {
  arn = var.secret_arn
}