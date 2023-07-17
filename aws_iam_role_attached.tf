resource "aws_iam_role" "jenkins_role" {
  name = "jenkins_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2full_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.jenkins_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.jenkins_role.name
  
}

resource "aws_iam_role_policy_attachment" "vpc_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  role       =  aws_iam_role.jenkins_role.name
}

resource "aws_iam_role_policy_attachment" "iam_policy" {
  policy_arn =  "arn:aws:iam::aws:policy/IAMFullAccess"
  role       =  aws_iam_role.jenkins_role.name
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name  = "jenkins_instance_profile"
  role = "${aws_iam_role.jenkins_role.name}"
}
