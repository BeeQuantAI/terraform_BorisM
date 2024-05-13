resource "aws_ecs_cluster" "BeeQuantAI_ecs_cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
resource "aws_ecs_task_definition" "BeeQuantAI_ecs_task_defination" {
  family = var.ecs_task_defination_family
  requires_compatibilities = ["FARGATE"]
  cpu = 2048
  memory = 6144
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn
  
  container_definitions = jsonencode([
    {
      name      = "platform_api"
      image     = var.image_uri
      cpu       = 512
      memory    = 3072
      essential = true
      logconfiguration = {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": var.BeeQuantAI_ecs_task_log_group,
          "awslogs-region": "ap-southeast-2",
          "awslogs-stream-prefix": "ecs"
        },
        "secretOptions": []
      }
      environment = [
    {
      name = "DB_PORT"
      value = "5432"
    },
    {
      name = "DB_HOST"
      value = var.db_host
    },
    {
      name = "DB_NAME"
      value = var.db_name
    },
    {
      name = "DB_USERNAME"
      value = var.db_username
    },
    {
      name = "DB_PASSWORD"
      value = var.db_password
    },
    {
      name = "JWT_SECRET"
      value = var.jwt_secret
    }
      ]
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          appprotocol  = "http2"
          protocol      = "TCP"
        }
      ]
    }
  ])
  ephemeral_storage {
    size_in_gib = 21
  }
}
resource "aws_cloudwatch_log_group" "BeeQuantAI_ecs_task_log_group" {
  name = var.BeeQuantAI_ecs_task_log_group
}