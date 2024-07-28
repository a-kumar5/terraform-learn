provider "aws" {
}

variable "avail_zone" {
}

variable "cidr_block" {
  description = "cidr block"
  type        = list(string)
}

variable "tags" {
  description = "list of tags objects"
  type = list(object({
    name = string
    env  = string
  }))
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_block[0]
  tags = {
    "Name" = var.tags[0].name
    "env"  = var.tags[0].env
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.cidr_block[1]
  availability_zone = var.avail_zone
  tags = {
    "Name" = var.tags[1].name
    "env"  = var.tags[1].env
  }
}

data "aws_vpc" "default-vpc" {
  default = true
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-1-id" {
  value = aws_subnet.dev-subnet-1.id
}
