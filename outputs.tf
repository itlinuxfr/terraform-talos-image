output "schematic_id" {
  description = "Image Factory schematic ID."
  type        = string
  value       = talos_image_factory_schematic.this.id
}

output "iso_url" {
  description = "ISO URL, the SecureBoot variant when secureboot.enabled is true."
  type        = string
  value       = var.secureboot.enabled ? local.urls.iso_secureboot : local.urls.iso
}

output "installer_image" {
  description = "Installer image for machine.install.image, the SecureBoot variant when secureboot.enabled is true."
  type        = string
  value       = var.secureboot.enabled ? local.urls.installer_secureboot : local.urls.installer
}

output "urls" {
  description = "All asset URLs of the Image Factory (iso, installer, disk_image, pxe, kernel, initramfs, uki and their SecureBoot variants). An asset that is not available gives an empty string."
  type        = map(string)
  value       = local.urls
}
