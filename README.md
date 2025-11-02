<!-- BEGIN_TF_DOCS -->
[![terraform-docs](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/documentation.yaml/badge.svg)](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/documentation.yaml)
[![terraform-lint](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/tflint.yaml/badge.svg)](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/tflint.yaml)
[![Provider: siderolabs/talos](https://img.shields.io/badge/provider-siderolabs%2Ftalos-623CE4?logo=terraform)](https://registry.terraform.io/providers/siderolabs/talos/latest)
[![Provider: siderolabs/talos v0.9.0](https://img.shields.io/badge/provider%3A%20siderolabs%2Ftalos-v0.9.0-623CE4?logo=terraform)](https://registry.terraform.io/providers/siderolabs/talos)

# Usage

```hcl
# You call the module via the desired source, example as workdir :
module "talos_image" {
  source               = "./modules/talos_image"
  talos_version        = "v1.11.3"
  talos_image_platform = "nocloud"
  talos_image_extensions = ["iscsi-tools", "util-linux-tools", "qemu-guest-agent",]
}

# You can use as output the URL for iso download :
output "talos_image_url" {
  value = module.talos_image.talos_image_url
}
```

> [!WARNING]  
> The output format for the URL is based on \_iso\_. These should be changed in the futur.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/0.9.0/docs/resources/image_factory_schematic) | resource |
| [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/0.9.0/docs/data-sources/image_factory_extensions_versions) | data source |
| [talos_image_factory_urls.this](https://registry.terraform.io/providers/siderolabs/talos/0.9.0/docs/data-sources/image_factory_urls) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_talos_image_extensions"></a> [talos\_image\_extensions](#input\_talos\_image\_extensions) | Talos Image Extensions | `list(string)` | `[]` | no |
| <a name="input_talos_image_platform"></a> [talos\_image\_platform](#input\_talos\_image\_platform) | Talos Platform Type for Image | `string` | n/a | yes |
| <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version) | Talos Version | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_talos_image_url"></a> [talos\_image\_url](#output\_talos\_image\_url) | Talos Generated URL ISO |
<!-- END_TF_DOCS -->
