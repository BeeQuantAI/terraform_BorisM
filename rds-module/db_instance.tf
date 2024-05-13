resource "aws_db_instance" "default" {
  allocated_storage    = 20
  identifier           = var.db_identifier
  db_name              = var.db_name
  engine               = "postgres"
  engine_version       = "16"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = var.db_password
  parameter_group_name = "testpg"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
  availability_zone    = element(var.availability_zones, 4)
  vpc_security_group_ids = [var.db_sg_id]
  port                 = 5432
  iam_database_authentication_enabled = false
  performance_insights_enabled = true
  performance_insights_retention_period = 731
  performance_insights_kms_key_id = var.kms_key_arn
  deletion_protection = false
}
output "db_host" {
  value = aws_db_instance.default.address
}