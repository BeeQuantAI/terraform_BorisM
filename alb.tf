resource "aws_lb" "platform_api_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.BeeQuantAI_subnets[0].id, aws_subnet.BeeQuantAI_subnets[1].id]

  enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.alb_logs.id
#     prefix  = "platform_api_alb"
#     enabled = true
#   }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "platform_api_listener" {
  load_balancer_arn = aws_lb.platform_api_alb.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.platform_api_tg.arn
  }
}

resource "aws_lb_target_group" "platform_api_tg" {
  name     = var.tg_name
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.platform_api_vpc.id
}