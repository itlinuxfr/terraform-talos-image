output "talos_image_url" {
  description = "Talos Generated URL ISO"
  value       = data.talos_image_factory_urls.this.urls.iso
}

output "talos_image_urls" {
  description = "Talos Generated URLs (ISO, PXE, etc)"
  value       = data.talos_image_factory_urls.this.urls
}

output "schematic_id" {
  description = "Talos Image Factory Schematic ID"
  value       = talos_image_factory_schematic.this.id
}
