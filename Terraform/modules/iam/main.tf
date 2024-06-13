resource "aws_iam_role" "jenkins_s3_role" {
  name = var.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jenkins_s3_role_attachment" {
  role       = aws_iam_role.jenkins_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.jenkins_s3_role.name
}

resource "aws_iam_policy" "jenkins_s3_policy" {
  name        = var.policy_name
  description = "Allows Jenkins EC2 instance to access S3 bucket for storing logs and artifacts"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "${var.bucket_arn}",
                "${var.bucket_arn}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "jenkins_s3_policy_attachment" {
  name       = var.policy_attachment_name
  policy_arn = aws_iam_policy.jenkins_s3_policy.arn
  roles      = [aws_iam_role.jenkins_s3_role.name]
}
