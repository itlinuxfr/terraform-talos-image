<!-- BEGIN_TF_DOCS -->
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