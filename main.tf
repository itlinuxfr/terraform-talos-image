# Generates a Talos Image Factory schematic and the download URLs of the matching images.
# The module only talks to the Image Factory: downloading or uploading the image is the caller's job.

locals {
  requested_extensions = sort(distinct(var.extensions))

  # Extension names confirmed by the Image Factory for this Talos version.
  extensions = length(local.requested_extensions) > 0 ? sort(data.talos_image_factory_extensions_versions.this[0].extensions_info[*].name) : []

  secureboot = merge(
    var.secureboot.enroll_keys != null ? { enrollKeys = var.secureboot.enroll_keys } : {},
    var.secureboot.include_well_known_certificates ? { includeWellKnownCertificates = true } : {},
  )

  # Only non-empty sections are written: the same inputs always give the same schematic ID.
  customization = merge(
    length(local.extensions) > 0 ? { systemExtensions = { officialExtensions = local.extensions } } : {},
    length(var.extra_kernel_args) > 0 ? { extraKernelArgs = var.extra_kernel_args } : {},
    length(local.secureboot) > 0 ? { secureboot = local.secureboot } : {},
  )

  urls = data.talos_image_factory_urls.this.urls
}

# Exact match, then a count check: a misspelled or unavailable extension must fail the plan instead of producing a wrong image.
data "talos_image_factory_extensions_versions" "this" {
  count = length(local.requested_extensions) > 0 ? 1 : 0

  talos_version = var.talos_version
  exact_filters = {
    names = local.requested_extensions
  }

  lifecycle {
    postcondition {
      condition     = length(self.extensions_info) == length(local.requested_extensions)
      error_message = "Unknown extension(s) for Talos ${var.talos_version}: ${join(", ", setsubtract(local.requested_extensions, [for e in self.extensions_info : e.name]))}."
    }
  }
}

resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode({ customization = local.customization })
}

data "talos_image_factory_urls" "this" {
  talos_version = var.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = var.platform
  architecture  = var.architecture
}
