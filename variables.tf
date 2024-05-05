variable "vpc_cidr" {
  type    = string
}
variable "vpc_name" {
  type    = string
}
variable "alb_name" {
  type    = string
}
variable "tg_name" {
  type    = string
}
variable "alb_sg_name" {
  type    = string
}
variable "db_sg_name" {
  type    = string
}
variable "environment" {
  type    = string
}
variable "ecr_repository_name" {
  type    = string
}
variable "rtb_private1a_name" {
  type    = string
}
variable "rtb_private2b_name" {
  type    = string
}
variable "rtb_private3c_name" {
  type    = string
}
variable "rtb_public_name" {
  type    = string
}
variable "igw_name" {
  type    = string
}
variable "BeeQuantAI_nat_public1_ap_southeast_2a" {
  type    = string
}
variable "BeeQuantAI_nat_public2_ap_southeast_2b" {
  type    = string
}
variable "subnet_cidr_blocks" {
  type    = list(string)
}
variable "subnet_names" {
  type    = list(string)
}
variable "availability_zones" {
  type    = list(string)
}
variable "BeeQuantAI_nat_name"{
  type    = list(string)
}
variable "rds_name" {
  type    = string
}
variable "secret_arn" {
  type    = string
}
variable "ecs_task_execution_role" {
  type    = string
}
variable "ecs_task_role" {
  type    = string
}
variable "ecs_task_role_policy" {
  type    = string
}
variable "ecs_cluster_name" {
  type    = string
}
variable "ecs_task_defination_family" {
  type    = string
}
variable "image_uri" {
  type    = string
}