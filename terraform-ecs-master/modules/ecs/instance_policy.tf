

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.environment}_ecs_instance_role"

  assume_role_policy = <<EOF

  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": [
                  "iam:CreateInstanceProfile",
                  "iam:RemoveRoleFromInstanceProfile",
                  "iam:AddRoleToInstanceProfile",
                  "iam:PassRole",
                  "iam:DeleteInstanceProfile"
              ],
              "Effect": "Allow",
              "Resource": "*"
          }
      ]
  }

EOF
}

resource "aws_iam_instance_profile" "ecs" {
  name = "${var.environment}_ecs_instance_profile"
  path = "/"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_role" {
  role       = aws_iam_role.ecs_instance_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_cloudwatch_role" {
  role       = aws_iam_role.ecs_instance_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
