<!-- BEGIN_TF_DOCS -->
[![terraform-docs](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/documentation.yaml/badge.svg)](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/documentation.yaml)
[![terraform-lint](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/tflint.yaml/badge.svg)](https://github.com/itlinuxfr/terraform-talos-image/actions/workflows/tflint.yaml)
[![Provider: siderolabs/talos](https://img.shields.io/badge/provider-siderolabs%2Ftalos-623CE4?logo=terraform)](https://registry.terraform.io/providers/siderolabs/talos/latest)
[![provider version: 0.9.0](https://img.shields.io/badge/Talos-%E2%89%A5%200.5%2C%20%3C%200.6-623CE4?logo=terraform)](https://registry.terraform.io/providers/siderolabs/talos)

# Usage

> [!WARNING]  
> At this stage of the dev, extensions are hardcoded.
> These extensions are coded : "iscsi-tools", "util-linux-tools", "qemu-guest-agent"
> TODO : Should create a list for that purpose

```hcl
# You call the module via the desired source, example as workdir :
module "talos_image" {
  source               = "./modules/talos_image"
  talos_version        = "v1.11.3"
  talos_image_platform = "nocloud"
}

# You can use as output the URL for iso download :
output "talos_image_url" {
  value = module.talos_image.talos_image_url
}
```

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
| <a name="input_talos_image_platform"></a> [talos\_image\_platform](#input\_talos\_image\_platform) | Talos Platform Type for Image | `string` | `"nocloud"` | no |
| <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version) | Talos Version | `string` | `"v1.11.3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_talos_image_url"></a> [talos\_image\_url](#output\_talos\_image\_url) | n/a |
<!-- END_TF_DOCS -->