resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.BeeQuantAI_subnets[4].id, aws_subnet.BeeQuantAI_subnets[3].id]

  tags = {
    Name = "My DB subnet group"
  }
}