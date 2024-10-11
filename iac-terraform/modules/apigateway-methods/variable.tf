variable "http_method" {
  type        = string
  description = "method type of API"
}
variable "resource_id" {
  type        = string
  description = "Id of the resource method is attached to"
}
variable "rest_api_id" {
  type        = string
  description = "Id of the REst API method id attached"
}

variable "integration_uri" {
  description = "The URI of the lambda integration this method will call"
  type        = string
}
variable "lambda_function_name" {
  description = "Lambda function name to which api trigger permission has to be set"
  type        = string
}

variable "resource_path" {
  description = "The given path of the resource"
  type        = string
}

variable "execution_arn" {
  description = "The execution ARN of the API"
  type        = string
}

variable "stage_name" {
  description = "The stage name"
  type        = string
}
variable "burst_limit" {
  description = "Number of concurrent requests"
  type        = number
  default     = 1
}

variable "rate_limit" {
  description = "Number of request per second"
  type        = number
  default     = 1
}
