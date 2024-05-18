terraform {
  backend "s3" {
    bucket         = "beequantai-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}