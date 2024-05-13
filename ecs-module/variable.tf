variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}
variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}
variable "ecs_task_execution_role" {
  description = "ECS task execution role"
  type        = string
}
variable "ecs_task_role" {
  description = "ECS task role"
  type        = string
}
variable "ecs_task_role_policy" {
  description = "ECS task role policy"
  type        = string
}
variable "ecs_task_defination_family" {
  description = "ECS task defination family"
  type        = string
}
variable "image_uri" {
  description = "Image URI"
  type        = string
}
variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}
variable "subnet_ids" {
  description = "Subnet ids"
  type        = list(string)
}
variable "alb_sg_id" {
  description = "Security groups"
  type        = string
}
variable "target_group_arn" {
  description = "Target group ARN"
  type        = string
}
variable "BeeQuantAI_ecs_task_log_group" {
  description = "ECS task log group"
  type        = string
}
variable "db_host" {
  description = "DB host"
  type        = string
}
variable "secret_arn" {
  description = "Secret ARN"
  type        = string
}
variable "db_name" {
  description = "DB name"
  type        = string
}
variable "db_password" {
  description = "DB password"
  type        = string
}
variable "db_username" {
  description = "DB username"
  type        = string
}
variable "jwt_secret" {
  description = "JWT secret"
  type        = string
}