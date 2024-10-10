module "url_shortner" {
  source    = "./modules/lambda"
  file_path = "./iac-terraform/lambda-function-code/url-shortner"
  name      = "urlShortner"
  policies = [
    data.aws_iam_policy_document.ur_shortner_lambda.json
  ]
}

module "redirect_lambda" {
  source    = "./modules/lambda"
  file_path = "./iac-terraform/lambda-function-code/url-shortner"
  name      = "urlShortner"
  policies = [
    data.aws_iam_policy_document.redirect_lambda.json
  ]
}
