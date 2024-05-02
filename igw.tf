resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.platform_api_vpc.id

  tags = {
    Name = var.igw_name
  }
}