resource "aws_route_table" "BeeQuantAI_rtb_private1_ap_southeast_2a" {
  vpc_id = aws_vpc.platform_api_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_nat_gateway.BeeQuantAI_nat_public1.id
  }

  tags = {
    Name = var.rtb_private1a_name
  }
}
resource "aws_route_table_association" "BeeQuantAI_rtb_association_private1_ap_southeast_2a" {
  subnet_id      = aws_subnet.BeeQuantAI_subnet_private1_ap_southeast_2a.id
  route_table_id = aws_route_table.BeeQuantAI_rtb_private1_ap_southeast_2a.id
}

resource "aws_route_table" "BeeQuantAI_rtb_private2_ap_southeast_2b" {
  vpc_id = aws_vpc.platform_api_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_nat_gateway.BeeQuantAI_nat_public2.id
  }

  tags = {
    Name = var.rtb_private2b_name
  }
}
resource "aws_route_table_association" "BeeQuantAI_rtb_association_private2_ap_southeast_2b" {
  subnet_id      = aws_subnet.BeeQuantAI_subnet_private2_ap_southeast_2b.id
  route_table_id = aws_route_table.BeeQuantAI_rtb_private2_ap_southeast_2b.id
}

resource "aws_route_table" "BeeQuantAI_rtb_public" {
  vpc_id = aws_vpc.platform_api_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rtb_public_name
  }
}
resource "aws_route_table_association" "BeeQuantAI_rtb_association_public1_ap_southeast_2a" {
  subnet_id      = aws_subnet.BeeQuantAI_subnet_public1_ap_southeast_2a.id
  route_table_id = aws_route_table.BeeQuantAI_rtb_public.id
}
resource "aws_route_table_association" "BeeQuantAI_rtb_association_public2_ap_southeast_2b" {
  subnet_id      = aws_subnet.BeeQuantAI_subnet_public2_ap_southeast_2b.id
  route_table_id = aws_route_table.BeeQuantAI_rtb_public.id
}

resource "aws_route_table" "BeeQuantAI_rtb_private3_ap_southeast_2c" {
  vpc_id = aws_vpc.platform_api_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = var.rtb_private3c_name
  }
}
resource "aws_route_table_association" "BeeQuantAI_rtb_association_private3_ap_southeast_2c" {
  subnet_id      = aws_subnet.BeeQuantAI_subnet_private3_ap_southeast_2c.id
  route_table_id = aws_route_table.BeeQuantAI_rtb_private3_ap_southeast_2c.id
}