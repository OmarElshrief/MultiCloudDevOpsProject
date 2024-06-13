resource "random_id" "bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "jenkins_bucket" {
  bucket               = "${var.bucket_name}${random_id.bucket_id.hex}"
  acl    = "private"
}
