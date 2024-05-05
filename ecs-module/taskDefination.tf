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
  operating_system_family = "LINUX"
  cpu = "0.5"
  memory = "2GB"
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn
  environment = [
    {
      name = "DB_PORT"
      value = "5432"
    },
    {
      name = "DB_HOST"
      value = "aws_secretsmanager_secret.secrets.secret_string:DB_HOST::"
    },
    {
      name = "DB_NAME"
      value = "aws_secretsmanager_secret.secrets.secret_string:DB_NAME::"
    },
    {
      name = "DB_USER"
      value = "aws_secretsmanager_secret.secrets.secret_string:DB_USER::"
    },
    {
      name = "DB_PASSWORD"
      value = "aws_secretsmanager_secret.secrets.secret_string:DB_PASSWORD::"
    },
    {
      name = "JWT_SECRET"
      value = "aws_secretsmanager_secret.secrets.secret_string:JWT_SECRET::"
    }
  ]
  container_definitions = jsonencode([
    {
      name      = "platform_api"
      image     = var.image_uri
      cpu       = 1
      memory    = 3
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          appprotocol  = "HTTP2"
          protocol      = "TCP"
        }
      ]
    },
    {
      name      = "aws-otel-collector"
      image     = "public.ecr.aws/aws-observability/aws-otel-collector:v0.38.1"
      cpu       = 0
      memory    = 256
      essential = true
      portMappings = []
      command = [
        "--config=/etc/ecs/ecs-cloudwatch-xray.yaml"
      ]
      logconfiguration {
        "logDriver": "awslogs",
        "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "/ecs/ecs-aws-otel-sidecar-collector",
        "awslogs-region": "ap-southeast-2",
        "awslogs-stream-prefix": "ecs"
        },
        "secretOptions": []
      }
    }
  ])
  enphemeral_storage {
    size_in_gib = 21
  }
  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }
}