resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Allow TCP inbound traffic to ecs alb"
  vpc_id      = aws_vpc.platform_api_vpc.id

  tags = {
    Name = "allow_api_tcp"
  }
}
resource "aws_vpc_security_group_ingress_rule" "alb_sg_inbound" {
  security_group_id = aws_security_group.alb_sg.id
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_egress_rule" "alb_sg_outbound" {
  security_group_id = aws_security_group.alb_sg.id
  # from_port         = 0
  ip_protocol       = "-1"
  # to_port           = 0
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "db_sg" {
  name        = var.db_sg_name
  description = "Allow backend api to connect to db"
  vpc_id      = aws_vpc.platform_api_vpc.id

  tags = {
    Name = "allow_db_tcp"
  }
}
resource "aws_vpc_security_group_ingress_rule" "db_sg_inbound" {
  security_group_id = aws_security_group.db_sg.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_egress_rule" "db_sg_outbound" {
  security_group_id = aws_security_group.db_sg.id
  # from_port         = 0
  ip_protocol       = "-1"
  # to_port           = 0
  cidr_ipv4         = "0.0.0.0/0"
}
