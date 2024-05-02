resource "aws_subnet" "BeeQuantAI_subnet_public1_ap_southeast_2a" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = var.BeeQuantAI_subnet_public1_ap_southeast_2a
  }
}

resource "aws_subnet" "BeeQuantAI_subnet_public2_ap_southeast_2b" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = var.BeeQuantAI_subnet_public2_ap_southeast_2b
  }
}

resource "aws_subnet" "BeeQuantAI_subnet_private1_ap_southeast_2a" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = var.BeeQuantAI_subnet_private1_ap_southeast_2a
  }
}

resource "aws_subnet" "BeeQuantAI_subnet_private2_ap_southeast_2b" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = var.BeeQuantAI_subnet_private2_ap_southeast_2b
  }
}

resource "aws_subnet" "BeeQuantAI_subnet_private3_ap_southeast_2c" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-southeast-2c"
  tags = {
    Name = var.BeeQuantAI_subnet_private3_ap_southeast_2c
  }
}