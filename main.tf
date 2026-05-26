resource "aws_elasticache_replication_group" "this" {
  count = local.enabled ? 1 : 0

  replication_group_id = module.this.id
  description          = coalesce(var.description, "Redis replication group ${module.this.id}")

  node_type            = var.node_type
  num_cache_clusters   = var.num_cache_clusters
  port                 = var.port
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = var.subnet_group_name
  security_group_ids   = var.security_group_ids

  engine_version             = var.engine_version
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token
  kms_key_id                 = var.kms_key_id

  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window
  maintenance_window       = var.maintenance_window

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  tags = local.tags
}
