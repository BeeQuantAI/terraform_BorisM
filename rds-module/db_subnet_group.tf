resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.BeeQuantAI_subnets_id[0], var.BeeQuantAI_subnets_id[1]]

  tags = {
    Name = "My DB subnet group"
  }
}