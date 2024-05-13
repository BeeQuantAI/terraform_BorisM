terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
resource "aws_vpc" "platform_api_vpc" {
 cidr_block           = var.vpc_cidr
 enable_dns_hostnames = true
 tags = {
   name = var.vpc_name
 }
}
resource "aws_subnet" "BeeQuantAI_subnets" {
  count = length(var.subnet_cidr_blocks)

  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = element(var.subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = element(var.subnet_names, count.index)
  }
}
resource "aws_nat_gateway" "BeeQuantAI_nat"{
  count = 2
  allocation_id = aws_eip.eip_nat[count.index].id
  subnet_id     = aws_subnet.BeeQuantAI_subnets[count.index].id

  tags = {
    Name = element(var.BeeQuantAI_nat_name, count.index)
  }

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.platform_api_vpc.id

  tags = {
    Name = var.igw_name
  }
}
resource "aws_eip" "eip_nat" {
  count    = 2
  domain   = "vpc"
}
resource "aws_ecr_repository" "backend" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
module "ecs" {
  source = "./ecs-module"
  ecs_cluster_name = var.ecs_cluster_name
  ecs_task_execution_role = var.ecs_task_execution_role
  ecs_task_role = var.ecs_task_role
  ecs_task_role_policy = var.ecs_task_role_policy
  ecs_task_defination_family = var.ecs_task_defination_family
  image_uri = var.image_uri
  subnet_ids = [aws_subnet.BeeQuantAI_subnets[2].id, aws_subnet.BeeQuantAI_subnets[3].id]
  alb_sg_id = aws_security_group.alb_sg.id
  target_group_arn = aws_lb_target_group.platform_api_tg.arn
  ecs_service_name = var.ecs_cluster_name
  BeeQuantAI_ecs_task_log_group = var.BeeQuantAI_ecs_task_log_group
  db_host = module.rds.db_host
  secret_arn = var.secret_arn
}
module "rds" {
  source = "./rds-module"
  db_identifier = var.db_identifier
  db_username = var.rds_name
  db_password = var.rds_name
  db_parameter_group_name = var.rds_name
  availability_zones = var.availability_zones
  subnet_cidr_blocks = var.subnet_cidr_blocks
  subnet_names = var.subnet_names
  kms_key_arn = var.kms_key_arn
  db_sg_id = aws_security_group.db_sg.id
  BeeQuantAI_subnets_id = [aws_subnet.BeeQuantAI_subnets[4].id, aws_subnet.BeeQuantAI_subnets[3].id]
}
