locals {
  project_name = "sls-module-project-${random_uuid.this.result}"
  store_name   = "sls-module-store-${random_uuid.this.result}"
  result_name  = var.use_random_suffix ? substr("${var.project_name}-${random_uuid.this.result}", 0, 63) : var.project_name
}

resource "random_uuid" "this" {}
