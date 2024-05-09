resource "aws_db_instance" "default" {
  allocated_storage    = 20
  db_name              = var.db_name
  engine               = "postgres"
  engine_version       = "16"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.db_parameter_group_name
  skip_final_snapshot  = true
  availability_zone    = element(var.availability_zones, 4)
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  port                 = 5432
  iam_database_authentication_enabled = false
  performance_insights_enabled = true
  performance_insights_retention_period = 100
  performance_insights_kms_key_id = var.kms_key_arn
  deletion_protection = true
}