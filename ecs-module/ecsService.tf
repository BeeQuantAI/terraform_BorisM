resource "aws_ecs_service" "BeeQuantAI_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.BeeQuantAI_ecs_cluster.id
  task_definition = aws_ecs_task_definition.BeeQuantAI_ecs_task_defination.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.BeeQuantAI_lb_target_group.arn
    container_name   = "platform_api"
    container_port   = 3000
  }
}