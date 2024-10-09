
resource "aws_api_gateway_rest_api" "UrlShortnerApi" {
  name        = "UrlShortnerApi"
  description = "This is my API for url shortner application"
}

resource "aws_api_gateway_resource" "UrlShortner" {
  rest_api_id = aws_api_gateway_rest_api.UrlShortnerApi.id
  parent_id   = aws_api_gateway_rest_api.UrlShortnerApi.root_resource_id
  path_part   = "urlshortner"
}

resource "aws_api_gateway_method" "UrlShortnerMethod" {
  authorization = "NONE"
  http_method   = var.http-method
  resource_id   = aws_api_gateway_resource.UrlShortner.id
  rest_api_id   = aws_api_gateway_rest_api.UrlShortnerApi.id
}
