provider "aws" {
  region = "ap-southeast-2"  # Specify your AWS region
}
resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_execution_role
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_assume_role_policy.json
}
data "aws_iam_policy_document" "ecs_task_execution_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
}
resource "aws_iam_role_policy_attachment" "Secrets_Manager_ReadWrite " {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = arn:aws:iam::aws:policy/SecretsManagerReadWrite
}