output "table_name" {
  description = "value of the DynamoDB table name"
  value = aws_dynamodb_table.table.name
}

output "table_arn" {
  description = "value of the DynamoDB table ARN"
  value = aws_dynamodb_table.table.arn
}