terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-k-sot"
    key = "stage/data-sources/mysql/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
#  password = data.aws_secretsmanager_secret_version.db_password
}

#data "aws_secretsmanager_secret_version" "db_password" {
#  secret_id = "psql-master-password-stage"
#}