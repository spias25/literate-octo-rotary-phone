resource "aws_dynamodb_table" "orders" {
  name = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "order_id"
  attribute {
    name = "order_id"
    type = "S"
  }
  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
  tags = var.tags
}
output "table_name" {
  value = aws_dynamodb_table.orders.name
}
output "table_arn" {
  value = aws_dynamodb_table.orders.arn
}
