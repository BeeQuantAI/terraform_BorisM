variable "db_identifier" {
  description = "DB identifier"
  type        = string
}
variable "db_username" {
  description = "DB username"
  type        = string
}
variable "db_password" {
  description = "DB password"
  type        = string
}
variable "db_parameter_group_name" {
  description = "DB parameter group name"
  type        = string
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}
variable "subnet_cidr_blocks" {
  description = "Subnet CIDR blocks"
  type        = list(string)
}
variable "subnet_names" {
  description = "Subnet names"
  type        = list(string)
}
variable "kms_key_arn" {
    description = "KMS key ARN"
    type        = string
}
variable "db_sg_id" {
  description = "DB security group ID"
  type        = string
}
variable "BeeQuantAI_subnets_id" {
    description = "Subnets ids"
    type        = list(string)
}