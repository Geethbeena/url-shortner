resource "aws_dynamodb_table" "url-table" {
  name           = "UrlMapTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "UrlCode"

  attribute {
    name = "UrlCode"
    type = "S"
  }
}
