# Providers & Terraform Version
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
  count         = length(var.talos_image_extensions) > 0 ? 1 : 0
  talos_version = var.talos_version
  filters = {
    names = var.talos_image_extensions
  }
}

# Create the yaml manifest for chosen extensions
resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    length(var.talos_image_extensions) > 0 ? {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.this[0].extensions_info[*].name
        }
      }
    } : {}
  )
}

# Generate the URL for the image based on the schematic id
data "talos_image_factory_urls" "this" {
  talos_version = var.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = var.talos_image_platform
}
