resource "aws_dynamodb_table" "url-table" {
  name           = "UrlMapTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "Id"
  range_key      = "UrlCode"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "UrlCode"
    type = "S"
  }

  attribute {
    name = "Url"
    type = "S"
  }
}
