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
module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "bqCore"

  engine            = "postgres"
  engine_version    = "16"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "bqCore"
  username = "postgres"
  port     = "3306"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = aws_security_group.db_sg.id

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = [aws_subnet.BeeQuantAI_subnets[3].id, aws_subnet.BeeQuantAI_subnets[4].id]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}