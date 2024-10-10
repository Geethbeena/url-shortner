output "arn" {
  value = aws_lambda_function.lambda_funtion.arn
}

output "name" {
  value = aws_lambda_function.lambda_funtion.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.lambda_funtion.invoke_arn
}

output "role_name" {
  value = aws_iam_role.iam_for_lambda.name
}
