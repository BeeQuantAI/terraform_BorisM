provider "aws" {
  region = "ap-southeast-2"
}
resource "aws_iam_role" "grafana_role" {
  name               = "GrafanaIAMRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "grafana.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_policy" "grafana_policy" {
  name   = "GrafanaIAMPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "cloudwatch:DescribeAlarms",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "tag:GetResources",
          "ec2:DescribeInstances",
          "ecs:DescribeClusters",
          "ecs:DescribeServices",
          "ecs:ListTasks",
          "ecs:DescribeTasks",
          "rds:DescribeDBInstances",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetHealth"
        ]
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "grafana_policy_attachment" {
  role       = aws_iam_role.grafana_role.name
  policy_arn = aws_iam_policy.grafana_policy.arn
}
resource "aws_grafana_workspace" "example" {
  name                   = var.workspace_name
  account_access_type    = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  role_arn               = aws_iam_role.grafana_role.arn
  data_sources           = ["CLOUDWATCH"]
}
resource "null_resource" "create_grafana_dashboard" {
  provisioner "local-exec" {
    command = <<EOT
      ../../grafana_dashboard.sh ${aws_grafana_workspace.example.endpoint} ${aws_iam_role.grafana_role.arn}
    EOT
  }
}
output "grafana_workspace_id" {
  value = aws_grafana_workspace.example.id
}

output "grafana_workspace_url" {
  value = aws_grafana_workspace.example.endpoint
}

output "grafana_workspace_iam_role_arn" {
  value = aws_iam_role.grafana_role.arn
}