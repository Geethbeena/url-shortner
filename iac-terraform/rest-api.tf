
resource "aws_api_gateway_rest_api" "url_shortner_api" {
  name        = "UrlShortnerApi"
  description = "This is my API for url shortner application"
}

resource "aws_api_gateway_resource" "url_shortner_api" {
  rest_api_id = aws_api_gateway_rest_api.url_shortner_api.id
  parent_id   = aws_api_gateway_rest_api.url_shortner_api.root_resource_id
  path_part   = "urlshortner"
}

module "post_url_method" {
  source               = "./modules/apigateway-methods"
  rest_api_id          = aws_api_gateway_rest_api.url_shortner_api.id
  http_method          = "POST"
  resource_id          = aws_api_gateway_resource.url_shortner_api.id
  resource_path        = aws_api_gateway_resource.url_shortner_api.path
  integration_uri      = module.url_shortner.invoke_arn
  lambda_function_name = module.url_shortner.name
  execution_arn        = aws_api_gateway_rest_api.url_shortner_api.execution_arn

}

module "redirect_url_method" {
  source               = "./modules/apigateway-methods"
  rest_api_id          = aws_api_gateway_rest_api.url_shortner_api.id
  http_method          = "GET"
  resource_id          = aws_api_gateway_resource.url_shortner_api.id
  resource_path        = aws_api_gateway_resource.url_shortner_api.path
  integration_uri      = module.redirect_lambda.invoke_arn
  lambda_function_name = module.redirect_lambda.name
  execution_arn        = aws_api_gateway_rest_api.url_shortner_api.execution_arn
}
