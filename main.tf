terraform {
  required_version = ">= 1.12.0"
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = "0.9.0"
    }
  }
}

# Find the latest version for extensions
data "talos_image_factory_extensions_versions" "this" {
  talos_version = var.talos_version
  filters = {
    names = [
      "iscsi-tools",
      "util-linux-tools",
      "qemu-guest-agent",
    ]
  }
}

# Create the yaml definition for choosen extensions
resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.this.extensions_info[*].name
        }
      }
    }
  )
}

# Generate the URL for the image based on the schematic id
data "talos_image_factory_urls" "this" {
  talos_version = var.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = var.talos_image_platform
}
