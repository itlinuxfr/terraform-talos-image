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
> The output format for the URL is based on _iso_. These should be changed in the futur.
