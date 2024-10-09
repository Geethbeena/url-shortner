module "api-gateway" {
  source      = "./modules/apigateway"
  http-method = "GET"
}
