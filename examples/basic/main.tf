# Minimal example: a Talos image for a cloud-init (nocloud) virtual machine with the QEMU guest agent.
# In a real project, pin the module source to a tag:
#   source = "git::https://github.com/itlinuxfr/terraform-talos-image.git?ref=v1.0.0"
# The relative source is used by CI: it tests the code of the current branch.

terraform {
  required_version = ">= 1.9"
}

module "talos_image" {
  source = "../../"

  talos_version = "v1.11.3"
  platform      = "nocloud"
  extensions    = ["siderolabs/qemu-guest-agent"]
}

output "iso_url" {
  value = module.talos_image.iso_url
}
