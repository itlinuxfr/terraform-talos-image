# terraform-talos-image

Generates a [Talos Linux Image Factory](https://factory.talos.dev) schematic and the URLs of the matching images: ISO, installer,
disk image, PXE and more. The module does not download or upload anything: pass `iso_url` to the module that fetches the image
for your hypervisor, and `installer_image` to the Talos machine configuration.

## Usage

```hcl
module "talos_image" {
  source = "git::https://github.com/itlinuxfr/terraform-talos-image.git?ref=v1.0.0"

  talos_version = "v1.11.3"
  platform      = "nocloud"
  extensions    = ["siderolabs/qemu-guest-agent"]

  secureboot = { enabled = true }
}
```

An extension name that does not exist for the chosen Talos version fails `terraform plan`. The plan queries the Image Factory,
so it needs network access.

See the [`examples/`](examples/) directory for complete examples.

## Contributing
Read [`AGENTS.md`](AGENTS.md) for conventions and commands, and [`SECURITY.md`](SECURITY.md) for security rules.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | >= 0.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) | resource |
| [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_extensions_versions) | data source |
| [talos_image_factory_urls.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version) | Talos Linux version, with the leading v (for example v1.11.3). | `string` | n/a | yes |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | CPU architecture of the image. | `string` | `"amd64"` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | Official system extensions to include, with their full name (for example siderolabs/qemu-guest-agent). An unknown name fails the plan. | `list(string)` | `[]` | no |
| <a name="input_extra_kernel_args"></a> [extra\_kernel\_args](#input\_extra\_kernel\_args) | Extra kernel arguments baked into the image (for example net.ifnames=0). | `list(string)` | `[]` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | Image Factory platform, for example metal, nocloud, aws or hcloud. See the Talos Image Factory documentation for the full list. | `string` | `"metal"` | no |
| <a name="input_secureboot"></a> [secureboot](#input\_secureboot) | SecureBoot options.<br/>- enabled: the iso\_url and installer\_image outputs return the SecureBoot variants.<br/>- enroll\_keys: how the image enrolls the SecureBoot keys on first boot: off, manual, if-safe or force.<br/>  Null keeps the Image Factory default (if-safe: enrolls only inside a virtual machine).<br/>- include\_well\_known\_certificates: add well-known UEFI certificates to the enrollment database. | <pre>object({<br/>    enabled                         = optional(bool, false)<br/>    enroll_keys                     = optional(string)<br/>    include_well_known_certificates = optional(bool, false)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_installer_image"></a> [installer\_image](#output\_installer\_image) | Installer image for machine.install.image, the SecureBoot variant when secureboot.enabled is true. |
| <a name="output_iso_url"></a> [iso\_url](#output\_iso\_url) | ISO URL, the SecureBoot variant when secureboot.enabled is true. |
| <a name="output_schematic_id"></a> [schematic\_id](#output\_schematic\_id) | Image Factory schematic ID. |
| <a name="output_urls"></a> [urls](#output\_urls) | All asset URLs of the Image Factory (iso, installer, disk\_image, pxe, kernel, initramfs, uki and their SecureBoot variants). An asset that is not available gives an empty string. |
<!-- END_TF_DOCS -->
