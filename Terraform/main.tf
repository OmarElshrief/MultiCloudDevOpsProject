provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block        = "10.0.0.0/16"
  subnet_cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

module "ec2" {
  source = "./modules/ec2"

  instance_type  = "t2.micro"
  subnet_id      = module.vpc.subnet_id
  security_group = module.vpc.security_group
  instance_name  = "Jenkins Instance"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  instance_id = module.ec2.instance_id
}

module "s3_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = "jenkins-logs-artifacts-bucket-"
}

module "iam" {
  source = "./modules/iam"

  role_name              = "jenkins_s3_role"
  instance_profile_name  = "jenkins_instance_profile"
  policy_name            = "jenkins_s3_policy"
  policy_attachment_name = "jenkins_s3_policy_attachment"
  bucket_arn             = module.s3_bucket.bucket_arn
}
