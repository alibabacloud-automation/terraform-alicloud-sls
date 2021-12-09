Alibaba Cloud SLS Terraform Module   
terraform-alicloud-sls


English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-sls/blob/master/README-CN.md)

Terraform module which creates log service's resources (SLS) on Alibaba Cloud.

These types of resources are supported:

* [Log Project](https://www.terraform.io/docs/providers/alicloud/r/log_project.html)
* [Log Store](https://www.terraform.io/docs/providers/alicloud/r/log_store.html)
* [Log Store_index](https://www.terraform.io/docs/providers/alicloud/r/log_store_index.html)

## Usage

```hcl

module "sls-module" {
  source                      = "terraform-alicloud-modules/sls/alicloud"
  create                      = true
  
  #############
  #log project#
  #############
  project_prefix              = "basic-project-name"
  
  ###########
  #log store#
  ###########
  store_name                  = "basic-store-name"
  store_retention_period      = 30
  store_shard_count           = 2
  store_auto_split            = true
  store_max_split_shard_count = 1
  store_append_meta           = true
  store_enable_web_tracking   = false
  
  #################
  #log store index#
  #################
  index_full_text = [
    {
      case_sensitive  = false
      include_chinese = false
      token           = "#"
    }
  ]
  index_field_search = [
    {
      name             = "basic"
      type             = "long"
      alias            = "basic1"
      case_sensitive   = true
      include_chinese  = true
      token            = "#"
      enable_analytics = "true"
      json_keys = [
        {
          name      = "basic_json_key"
          type      = "long"
          alias     = "basic_json_key1"
          doc_value = true
        }
      ]
    }
  ]
}
```

## Examples

* [Basic example](https://github.com/terraform-alicloud-modules/terraform-alicloud-sls/tree/master/examples/basic)

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  version                 = ">=1.69.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/sls/alicloud"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

```hcl
module "sls-module" {
  source  = "terraform-alicloud-modules/sls/alicloud"
  version     = "1.0.0"
  region      = "cn-beijing"
  profile     = "Your-Profile-Name"
  create                      = true
  project_prefix              = "basic-project-name"
  // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
}
module "sls-module" {
  source  = "terraform-alicloud-modules/sls/alicloud"
  create                      = true
  project_prefix              = "basic-project-name"
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
  alias   = "bj"
}
module "sls-module" {
  source  = "terraform-alicloud-modules/sls/alicloud"
  providers = {
    alicloud = alicloud.bj
  }
  create                      = true
  project_prefix              = "basic-project-name"
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.69.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)