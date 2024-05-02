resource "aws_nat_gateway" "BeeQuantAI_nat_public1" {
  allocation_id = aws_eip.eip_nat_public1.id
  subnet_id     = aws_subnet.BeeQuantAI_subnet_public1_ap_southeast_2a.id

  tags = {
    Name = var.BeeQuantAI_nat_public1_ap_southeast_2a
  }

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "BeeQuantAI_nat_public2" {
  allocation_id = aws_eip.eip_nat_public2.id
  subnet_id     = aws_subnet.BeeQuantAI_subnet_public2_ap_southeast_2b.id

  tags = {
    Name = var.BeeQuantAI_nat_public2_ap_southeast_2b
  }

  depends_on = [aws_internet_gateway.igw]
}