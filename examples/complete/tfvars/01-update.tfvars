#alicloud_log_project
description = "update-project-description"

#alicloud_log_store
store_retention_period      = 60
store_shard_count           = 3
store_auto_split            = true
store_max_split_shard_count = 2
store_append_meta           = false
store_enable_web_tracking   = true

#alicloud_log_store_index
index_full_text = [
  {
    // Whether the case sensitive. Default to false.
    case_sensitive = true
    // Whether includes the chinese. Default to false.
    include_chinese = true
    // The string of several split words, like "\r", "#"
    token = "\r"
  }
]

index_field_search = [
  {
    name             = "update"
    type             = "double"
    alias            = "update1"
    case_sensitive   = false
    include_chinese  = false
    token            = "\r"
    enable_analytics = "false"
    json_keys = [
      {
        name      = "update_json_key"
        type      = "double"
        alias     = "update_json_key1"
        doc_value = false
      }
    ]
  }
]