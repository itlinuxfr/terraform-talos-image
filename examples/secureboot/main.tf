# SecureBoot example: the image enrolls the Sidero keys itself (firmware in setup mode).
# Use iso_url to boot the machine and installer_image in the Talos machine configuration (machine.install.image).

terraform {
  required_version = ">= 1.15"
}

module "talos_image" {
  source = "../../"

  talos_version = "v1.14.6"
  platform      = "nocloud"
  extensions    = ["siderolabs/qemu-guest-agent"]

  secureboot = {
    enabled     = true
    enroll_keys = "if-safe"
  }
}

output "iso_url" {
  value = module.talos_image.iso_url
}

output "installer_image" {
  value = module.talos_image.installer_image
}
