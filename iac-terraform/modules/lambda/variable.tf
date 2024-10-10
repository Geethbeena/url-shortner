variable "file_path" {
  description = "path of the lambda function source code"
  type        = string
}

variable "name" {
  description = "name of the lambda funtion"
  type        = string
}

variable "policies" {
  description = "The policies for lambda functions."
  type        = list(string)
  default     = null
}

variable "environment_variables" {
  description = "The environment variables used in the lambda functions."
  type        = map(string)
  default     = null
}
