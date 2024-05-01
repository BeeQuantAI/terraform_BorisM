resource "aws_subnet" "BeeQuantAI-subnet-public1-ap-southeast-2a" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "BeeQuantAI-subnet-public1-ap-southeast-2a"
  }
}

resource "aws_subnet" "BeeQuantAI-subnet-public2-ap-southeast-2b" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "BeeQuantAI-subnet-public2-ap-southeast-2b"
  }
}

resource "aws_subnet" "BeeQuantAI-subnet-private1-ap-southeast-2a" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "BeeQuantAI-subnet-private1-ap-southeast-2a"
  }
}

resource "aws_subnet" "BeeQuantAI-subnet-private2-ap-southeast-2b" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "BeeQuantAI-subnet-private2-ap-southeast-2b"
  }
}

resource "aws_subnet" "BeeQuantAI-uat-vpc-subnet-private3-ap-southeast-2c" {
  vpc_id     = aws_vpc.platform_api_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-southeast-2c"
  tags = {
    Name = "BeeQuantAI-subnet-private3-ap-southeast-2c"
  }
}