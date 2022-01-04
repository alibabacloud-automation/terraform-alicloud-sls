module "basic-sls-module" {
  source = "../.."

  #alicloud_log_project
  create            = true
  project_name      = "project-name"
  use_random_suffix = true
  description       = var.description

  #alicloud_log_store
  store_name                  = "store-name"
  store_retention_period      = var.store_retention_period
  store_shard_count           = var.store_shard_count
  store_auto_split            = var.store_auto_split
  store_max_split_shard_count = var.store_max_split_shard_count
  store_append_meta           = var.store_append_meta
  store_enable_web_tracking   = var.store_enable_web_tracking

  #alicloud_log_store_index
  index_full_text    = var.index_full_text
  index_field_search = var.index_field_search
}