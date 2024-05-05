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