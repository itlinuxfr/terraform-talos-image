variable "talos_version" {
  type        = string
  default     = "v1.11.3"
  description = "Talos Version"
}

variable "talos_image_platform" {
  type        = string
  default     = "nocloud"
  description = "Talos Platform Type for Image"
}
