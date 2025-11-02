output "talos_image_url" {
  description = "Talos Generated URL ISO"
  value       = data.talos_image_factory_urls.this.urls.iso
}
