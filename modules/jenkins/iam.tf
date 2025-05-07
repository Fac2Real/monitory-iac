// iam.tf

data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "jenkins_controller" {
  name               = "jenkins-controller-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

resource "aws_iam_role_policy" "jenkins_controller_policy" {
  name = "jenkins-controller-ec2"
  role = aws_iam_role.jenkins_controller.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ec2:RunInstances",
        "ec2:TerminateInstances",
        "ec2:DescribeInstances",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_instance_profile" "jenkins_controller" {
  name = "jenkins-controller-profile"
  role = aws_iam_role.jenkins_controller.name
}
