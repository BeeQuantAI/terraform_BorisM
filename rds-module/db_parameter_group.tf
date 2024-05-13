# resource "aws_db_parameter_group" "beequantai_db_parameter_group" {
#   name   = var.db_parameter_group_name
#   family = "postgres16"

#   parameter {
#     name  = "force_ssl"
#     value = "0"  # 0 means false
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }