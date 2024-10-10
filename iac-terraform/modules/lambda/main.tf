resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "lambda_funtion" {
  filename      = data.archive_file.lambda_code_source.output_path
  function_name = var.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = " index.lambda_handler"

  source_code_hash = data.archive_file.lambda_code_source.output_base64sha256

  runtime = "python3.8"

  environment {
    variables = var.environment_variables
  }
}
