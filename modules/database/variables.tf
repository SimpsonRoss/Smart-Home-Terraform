variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
} 

variable "hash_key" {
  description = "The hash key/partition key of the table"
  type        = string
}

variable "hash_key_type" {
  description = "The type of the hash key"
  type        = string
}