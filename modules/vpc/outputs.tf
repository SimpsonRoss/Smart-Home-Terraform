output "vpc_id" {
  description = "value of the VPC ID, incase I need to pass to other modules or resources"
  value = aws_vpc.main.id
}