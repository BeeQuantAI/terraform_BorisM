variable "workspace_name" {
  description = "Name of the Amazon Managed Grafana workspace"
  default     = "my-grafana-workspace"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
}

variable "rds_instance_id" {
  description = "ID of the RDS instance"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
}

variable "ami" {
  description = "AMI to use for the EC2 instance"
}

variable "vpc_id" {
  description = "ID of the VPC where ECS services and RDS instances are deployed"
}