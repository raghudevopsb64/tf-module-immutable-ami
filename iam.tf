resource "aws_iam_policy" "policy" {
  name        = "${var.COMPONENT}-ami-secret-manager-read-policy"
  path        = "/"
  description = "${var.COMPONENT}-ami-secret-manager-read-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Resource" : "arn:aws:secretsmanager:us-east-1:739561048503:secret:roboshop-lTGHdX"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:ListSecrets"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "ec2-role" {
  name = "${var.COMPONENT}-ami-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.COMPONENT}-ami-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "attach-policy" {
  role       = aws_iam_role.ec2-role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "${var.COMPONENT}-ami-ec2-role"
  role = aws_iam_role.ec2-role.name
}



