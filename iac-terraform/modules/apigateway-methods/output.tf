output "id" {
  value = aws_api_gateway_method.url_shortner_api_method.id
}

output "integration_id" {
  value = aws_api_gateway_integration.url_shortner_api_integration.id
}
