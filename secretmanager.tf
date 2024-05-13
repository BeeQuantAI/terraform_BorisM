# data "aws_secretsmanager_secret" "secrets" {
#   arn = var.secret_arn
# }
# output "db_username" {
#   value = jsondecode(data.aws_secretsmanager_secret.secrets.secret_string)["DB_USERNAME"]
# }
# output "db_password" {
#   value = jsondecode(data.aws_secretsmanager_secret.secrets.secret_string)["DB_PASSWORD"]
# }
# output "db_name" {
#   value = jsondecode(data.aws_secretsmanager_secret.secrets.secret_string)["DB_NAME"]
# }
# output "JWT_SECRET" {
#   value = jsondecode(data.aws_secretsmanager_secret.secrets.secret_string)["JWT_SECRET"]
# }