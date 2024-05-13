# data "aws_secretsmanager_secret" "secrets" {
#   arn = var.secret_arn
# }
# output "db_username" {
#   value = jsondecode(data.aws_secretsmanager_secret.secrets.secret_string)["db_host"]
# }