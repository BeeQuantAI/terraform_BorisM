resource "aws_vpc" "platform_api_vpc" {
 cidr_block           = var.vpc_cidr
 enable_dns_hostnames = true
 tags = {
   name = var.vpc_name
 }
}
