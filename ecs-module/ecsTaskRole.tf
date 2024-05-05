provider "aws" {
  region = "ap-southeast-2"  # Specify your AWS region
}
resource "aws_iam_role" "ecs_task_role" {
  name = var.ecs_task_role
  assume_role_policy = data.aws_iam_policy_document.ecs_task_role_assume_role_policy.json
}
data "aws_iam_policy_document" "ecs_task_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_policy" "ecs_task_role_policy" {
    name        = var.ecs_task_role_policy
    description = "Policy for ECS Task Role"
    policy      = data.aws_iam_policy_document.ecs_task_role_policy.json
}
data "aws_iam_policy_document" "ecs_task_role_policy" {
  statement {
    actions = [
      "rds:*"
    ]
    resources = [
      "arn:aws:rds:::var.rds_name"
    ]
  }
}
resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_role_policy.arn
}