resource "aws_eip" "eip_nat_public1" {
  domain   = "vpc"
}
resource "aws_eip" "eip_nat_public2" {
  domain   = "vpc"
}