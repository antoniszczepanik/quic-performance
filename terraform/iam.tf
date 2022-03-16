// resource "aws_iam_role" "mail_sender_role" {
//   name = "mail_sender_role"
//   assume_role_policy = jsonencode({
//     Version = "2012-10-17"
//     Statement = [
//       {
//         Action = "sts:AssumeRole"
//         Effect = "Allow"
//         Sid    = ""
//         Principal = {
//           Service = "ec2.amazonaws.com"
//         }
//       },
//     ]
//   })
// }
// 
// resource "aws_iam_policy" "mail_sender_policy" {
//   name        = "mail_sender_policy"
//   path        = "/"
//   description = "Policy allowing to send mail via SES"
// 
//   policy = jsonencode({
//     Version = "2012-10-17"
//     Statement = [
//       {
//         Action = [
//           "ses:SendRawEmail",
//           "ses:SendEmail"
//         ]
//         Effect   = "Allow"
//         Resource = "*"
//       },
//     ]
//   })
// }
// resource "aws_iam_policy_attachment" "mail_sender_policy_attachment" {
//   name       = "mail_sender_policy_attachment"
//   roles      = [aws_iam_role.mail_sender_role.name]
//   policy_arn = aws_iam_policy.mail_sender_policy.arn
// }
// 
// resource "aws_iam_instance_profile" "mail_sender_profile" {
//   name = "mail_sender_profile"
//   role = aws_iam_role.mail_sender_role.name
// }
