resource "aws_iam_role" "devops" {
  name = "devops"

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
        },
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::${var.devops_account}:root"
          },
          "Action": "sts:AssumeRole",
          "Condition": {}
        }
      ]
    }
EOF
}

resource "aws_iam_policy" "devops" {
  name        = "devops-policy"
  description = "A devops policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "devops-attach" {
  role       = "${aws_iam_role.devops.name}"
  policy_arn = "${aws_iam_policy.devops.arn}"
}
