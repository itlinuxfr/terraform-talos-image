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
