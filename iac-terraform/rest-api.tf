
resource "aws_api_gateway_rest_api" "url_shortner_api" {
  name        = "UrlShortnerApi"
  description = "This is my API for url shortner application"
}

resource "aws_api_gateway_resource" "redirect_resource" {
  rest_api_id = aws_api_gateway_rest_api.url_shortner_api.id
  parent_id   = aws_api_gateway_rest_api.url_shortner_api.root_resource_id
  path_part   = "{code}"
}

resource "aws_api_gateway_deployment" "url_shortner_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.url_shortner_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.url_shortner_api.root_resource_id,
      aws_api_gateway_resource.redirect_resource.id,
      module.post_url_method.id,
      module.post_url_method.integration_id,
      module.redirect_url_method.id,
      module.redirect_url_method.integration_id
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "url_shortner_api_stage" {
  deployment_id = aws_api_gateway_deployment.url_shortner_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.url_shortner_api.id
  stage_name    = "development"
}

module "post_url_method" {
  source               = "./modules/apigateway-methods"
  rest_api_id          = aws_api_gateway_rest_api.url_shortner_api.id
  http_method          = "POST"
  resource_id          = aws_api_gateway_rest_api.url_shortner_api.root_resource_id
  resource_path        = "/"
  integration_uri      = module.url_shortner.invoke_arn
  lambda_function_name = module.url_shortner.name
  execution_arn        = aws_api_gateway_rest_api.url_shortner_api.execution_arn
  stage_name           = aws_api_gateway_stage.url_shortner_api_stage.stage_name

}

module "redirect_url_method" {
  source               = "./modules/apigateway-methods"
  rest_api_id          = aws_api_gateway_rest_api.url_shortner_api.id
  http_method          = "GET"
  resource_id          = aws_api_gateway_resource.redirect_resource.id
  resource_path        = aws_api_gateway_resource.redirect_resource.path
  integration_uri      = module.redirect_lambda.invoke_arn
  lambda_function_name = module.redirect_lambda.name
  execution_arn        = aws_api_gateway_rest_api.url_shortner_api.execution_arn
  stage_name           = aws_api_gateway_stage.url_shortner_api_stage.stage_name
}
