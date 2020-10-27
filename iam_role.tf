resource "aws_iam_role" "wp-offload" {
  name = "wp-offload"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.wp-offload.name
}


resource "aws_iam_role_policy" "wp-offload" {
  name = "wp-offload"
  role = aws_iam_role.wp-offload.id

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1601591974377",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::34rt3tttt",
        "arn:aws:s3:::34rt3tttt/*"
      ]
    }
  ]
}
  EOF
}