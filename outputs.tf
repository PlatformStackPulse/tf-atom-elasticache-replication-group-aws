output "id" {
  description = "ID of the replication group"
  value       = try(aws_elasticache_replication_group.this[0].id, null)
}

output "arn" {
  description = "ARN of the replication group"
  value       = try(aws_elasticache_replication_group.this[0].arn, null)
}

output "primary_endpoint_address" {
  description = "Primary endpoint address"
  value       = try(aws_elasticache_replication_group.this[0].primary_endpoint_address, null)
}

output "reader_endpoint_address" {
  description = "Reader endpoint address"
  value       = try(aws_elasticache_replication_group.this[0].reader_endpoint_address, null)
}

output "port" {
  description = "Port number"
  value       = try(aws_elasticache_replication_group.this[0].port, null)
}
