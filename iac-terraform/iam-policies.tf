data "aws_iam_policy_document" "ur_shortner_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
    ]

    resources = [
      aws_dynamodb_table.url-table.arn
    ]
  }
}

data "aws_iam_policy_document" "redirect_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
    ]

    resources = [
      aws_dynamodb_table.url-table.arn
    ]
  }
}
