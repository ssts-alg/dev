resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Service" : "ec2.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
          }
        ]
      }
    ]
  })

  tags = {
    Name = "ec2_role"
  }
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}


resource "aws_iam_policy_attachment" "test-attach" {
  count      = length(var.policy_arn_list)
  name       = "test-attachment"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = var.policy_arn_list[count.index]
}

variable "policy_arn_list" {
  type    = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
}


resource "aws_iam_policy" "policy" {
  name        = "ec2_test_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Stmt1622964868451",
        "Action" : [
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "test-attach1" {
  name       = "test-attachment1"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = aws_iam_policy.policy.arn
}
