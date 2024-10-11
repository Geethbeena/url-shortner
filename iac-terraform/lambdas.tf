module "url_shortner" {
  source    = "./modules/lambda"
  file_path = "./lambda-function-code/url-shortner"
  name      = "urlShortner"
  policies = [
    data.aws_iam_policy_document.ur_shortner_lambda.json
  ]
  environment_variables = {
    "TABLE_NAME" : local.table_name
  }
}

module "redirect_lambda" {
  source    = "./modules/lambda"
  file_path = "./lambda-function-code/redirect"
  name      = "redirectLambda"
  policies = [
    data.aws_iam_policy_document.redirect_lambda.json
  ]
  environment_variables = {
    "TABLE_NAME" : local.table_name
  }
}
