Alibaba Cloud SLS Terraform Module   
terraform-alicloud-sls
=====================================================================

本 Module 用于在阿里云创建一套日志服务相关资源. 

本 Module 支持创建以下资源:

* [Log Project](https://www.terraform.io/docs/providers/alicloud/r/log_project.html)
* [Log Store](https://www.terraform.io/docs/providers/alicloud/r/log_store.html)
* [Log Store_index](https://www.terraform.io/docs/providers/alicloud/r/log_store_index.html)


## 用法

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

## 示例

* [基本示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-sls/tree/master/examples/basic)

## 注意事项
本Module从版本v1.1.0开始已经移除掉如下的 provider 的显示设置：

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

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.0.0:

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

如果你想对正在使用中的Module升级到 1.1.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
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
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

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

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)