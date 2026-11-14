variable "talos_version" {
  description = "Talos Linux version, with the leading v (for example v1.11.3)."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^v[0-9]+\\.[0-9]+\\.[0-9]+(-[0-9A-Za-z.]+)?$", var.talos_version))
    error_message = "The Talos version must look like v1.11.3 (leading v, three numbers, optional pre-release suffix)."
  }
}

variable "platform" {
  description = "Image Factory platform, for example metal, nocloud, aws or hcloud. See the Talos Image Factory documentation for the full list."
  type        = string
  default     = "metal"
  nullable    = false
}

variable "architecture" {
  description = "CPU architecture of the image."
  type        = string
  default     = "amd64"
  nullable    = false

  validation {
    condition     = contains(["amd64", "arm64"], var.architecture)
    error_message = "The architecture must be amd64 or arm64."
  }
}

variable "extensions" {
  description = "Official system extensions to include, with their full name (for example siderolabs/qemu-guest-agent). An unknown name fails the plan."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "extra_kernel_args" {
  description = "Extra kernel arguments baked into the image (for example net.ifnames=0)."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for arg in var.extra_kernel_args : trimspace(arg) != ""])
    error_message = "Kernel arguments must not be empty."
  }
}

variable "secureboot" {
  description = <<-EOT
    SecureBoot options.
    - enabled: the iso_url and installer_image outputs return the SecureBoot variants.
    - enroll_keys: how the image enrolls the SecureBoot keys on first boot: off, manual, if-safe or force.
      Null keeps the Image Factory default (if-safe: enrolls only inside a virtual machine).
    - include_well_known_certificates: add well-known UEFI certificates to the enrollment database.
  EOT
  type = object({
    enabled                         = optional(bool, false)
    enroll_keys                     = optional(string)
    include_well_known_certificates = optional(bool, false)
  })
  default  = {}
  nullable = false

  validation {
    condition     = var.secureboot.enroll_keys == null ? true : contains(["off", "manual", "if-safe", "force"], var.secureboot.enroll_keys)
    error_message = "secureboot.enroll_keys must be off, manual, if-safe or force."
  }
}
