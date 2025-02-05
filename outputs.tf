output "iam_user_login_credentials" {
  value = { for user in aws_iam_user_login_profile.user_passwords : user.user => user.password }
  sensitive = true
}