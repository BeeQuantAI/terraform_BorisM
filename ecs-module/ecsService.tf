resource "aws_ecs_service" "BeeQuantAI_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.BeeQuantAI_ecs_cluster.id
  task_definition = aws_ecs_task_definition.BeeQuantAI_ecs_task_defination.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.alb_sg_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "platform_api"
    container_port   = 3000
  }
}