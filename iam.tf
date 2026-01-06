resource "aws_iam_role" "our_iam_role" {
  name = "terraformadmin"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        sid = ""
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "our_iam_role_attach" {
  role       = aws_iam_role.our-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

}
resource "aws_iam_instance_profile" "our-iam-instance-profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.our-iam-role.name
}