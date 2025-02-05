
resource "aws_iam_group" "admin_group" {
  name = "admin-group"
}


resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.admin_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "users" {
  for_each = toset(var.iam_users)
  name     = each.key
}


resource "aws_iam_user_group_membership" "admin_membership" {
  for_each = toset(var.iam_users)
  user     = each.key
  groups   = [aws_iam_group.admin_group.name]
}


resource "aws_iam_user_login_profile" "user_passwords" {
  for_each                = toset(var.iam_users)
  user                    = each.key
  password_length         = 16
  password_reset_required = true
}


