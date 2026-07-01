# Unit Tests — tf-atom-elasticache-replication-group-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run one test:     terraform test -test-directory=tests/unit -run "creates_when_enabled"
#
# NOTE: Assertions target plan-KNOWN values only (the tf-label id string,
# the resource count, and input pass-throughs). Computed attributes such as
# arn / primary_endpoint_address are UNKNOWN under a mock provider and must
# not be asserted on directly.

mock_provider "aws" {}

variables {
  # tf-label context
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # Module inputs (valid sample values)
  node_type          = "cache.t3.micro"
  num_cache_clusters = 2
  port               = 6379
  engine_version     = "7.1"
  security_group_ids = ["sg-0123456789abcdef0"]
  description        = "Redis for unit test"
}

# ---------------------------------------------------------------------------
# Test: module creates the replication group when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  # Exactly one replication group is planned when enabled (count is known at plan).
  assert {
    condition     = length(aws_elasticache_replication_group.this) == 1
    error_message = "Expected exactly one replication group when enabled = true."
  }

  # Configured input pass-throughs are known at plan time.
  assert {
    condition     = aws_elasticache_replication_group.this[0].port == 6379
    error_message = "Port should be passed through to the replication group."
  }

  assert {
    condition     = aws_elasticache_replication_group.this[0].num_cache_clusters == 2
    error_message = "num_cache_clusters should be passed through to the replication group."
  }

  assert {
    condition     = aws_elasticache_replication_group.this[0].engine_version == "7.1"
    error_message = "engine_version should be passed through to the replication group."
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_elasticache_replication_group.this) == 0
    error_message = "No replication group should be planned when enabled = false."
  }

  assert {
    condition     = output.arn == null
    error_message = "arn output should be null when the module is disabled."
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled."
  }
}
