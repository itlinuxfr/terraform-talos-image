variable "talos_version" {
  type        = string
  description = "Talos Version"
  validation {
    condition     = can(regex("^v", var.talos_version))
    error_message = "Talos version must start with 'v' (e.g. v1.8.0)."
  }
}

variable "talos_image_extensions" {
  type        = list(string)
  description = "Talos Image Extensions"
  default     = []
}

variable "talos_image_platform" {
  type        = string
  description = "Talos Platform Type for Image"
  validation {
    condition     = contains(["aws", "gcp", "equinixMetal", "azure", "digital-ocean", "nocloud", "openstack", "vmware", "akamai", "cloudstack", "hcloud", "oracle", "upcloud", "vultr", "exoscale", "opennebula", "scaleway", "metal"], var.talos_image_platform)
    error_message = "Please provide a valid Talos image platform type"
  }
}
