terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region  = var.region
  profile = "default"
}

module "tf-vpc" {
  source     = "./VPC"
  cidr-block = var.cidr-block
  vpc-tag    = var.vpc-tag
}


module "tf-subnet" {
  source = "./Subnet"
  vpc    = module.tf-vpc.vpc
  sub    = var.sub
}


module "tf-security-group" {
  source  = "./SG"
  vpc     = module.tf-vpc.vpc
  cidr-SG = var.cidr-SG
}


module "tf-igw" {
  source           = "./IGW"
  vpc              = module.tf-vpc.vpc
  internet-gateway = var.internet-gateway

}


module "tf-route-table" {
  source     = "./RT"
  vpc        = module.tf-vpc.vpc
  sub_pub    = [ module.tf-subnet.sub-pub ]
  cidr-rt    = var.cidr-rt
  igw        = module.tf-igw.igw
  tag_public = var.tag_public
}


module "tf-instance" {
  source           = "./EC2"
  sub_pub          = [ module.tf-subnet.sub-pub ]
  sg-pub           = module.tf-security-group.sg-pub
  ec2-type = var.type-ec2
  profile_instance = "Terraform"
  key-pair = var.key-pair
}


module "tf-cloudwatch" {
  source = "./CloudWatch"
  ec2    = module.tf-instance.ec2_id[0]
  email  = var.email
  time   = var.time
}


module "tf-s3" {
  source        = "./S3"
  name_bucket   = var.name_bucket
  region_bucket = var.region_bucket

}

