# Trust policy: only the EC2 service assumes role
data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app" {
  name               = "${var.project}-lab-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

# Session Manager access
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# policy app need
data "aws_iam_policy_document" "app_access" {
  statement {
    sid = "SqsAppQueue"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ChangeMessageVisibility",
    ]
    resources = [aws_sqs_queue.analysis.arn]
  }

  statement {
    sid       = "ReadDbSecret"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [aws_secretsmanager_secret.db.arn]
  }

  statement {
    sid       = "WriteContainerLogs"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.app.arn}:*"]
  }
}

resource "aws_iam_role_policy" "app_access" {
  name   = "${var.project}-app-access"
  role   = aws_iam_role.app.id
  policy = data.aws_iam_policy_document.app_access.json
}

# The wrapper that lets an EC2 instance use the role
resource "aws_iam_instance_profile" "app" {
  name = "${var.project}-lab-ec2-profile"
  role = aws_iam_role.app.name
}