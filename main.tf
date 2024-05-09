terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "poridhi.tito"
}

# Create VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
  #enable_dns_support = true
  #enable_dns_hostnames = true

  tags = {
    Name = "iac-vpc"
  }
}

# Create public subnet
resource "aws_subnet" "tf_public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.tf_vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 
 tags = {
   Name = "TF Public Subnet ${count.index + 1}"
 }
}
 
# Create private subnet
resource "aws_subnet" "tf_private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.tf_vpc.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 
 tags = {
   Name = "TF Private Subnet ${count.index + 1}"
 }
}
 
 
