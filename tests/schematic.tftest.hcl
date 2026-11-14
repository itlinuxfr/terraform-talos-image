# Tests without real infrastructure: the Image Factory is replaced by a mock provider.
# Runs that read outputs use `command = apply`: the schematic ID is unknown at plan time, and nothing real is created.

mock_provider "talos" {
  mock_data "talos_image_factory_urls" {
    defaults = {
      urls = {
        disk_image            = "https://factory.example/disk.raw.xz"
        disk_image_secureboot = "https://factory.example/disk-secureboot.raw.xz"
        initramfs             = "https://factory.example/initramfs.xz"
        installer             = "factory.example/installer:v1.11.3"
        installer_secureboot  = "factory.example/installer-secureboot:v1.11.3"
        iso                   = "https://factory.example/image.iso"
        iso_secureboot        = "https://factory.example/image-secureboot.iso"
        kernel                = "https://factory.example/kernel"
        kernel_command_line   = "https://factory.example/cmdline"
        pxe                   = "https://factory.example/pxe"
        uki                   = "https://factory.example/uki.efi"
      }
    }
  }
}

run "empty_schematic" {
  command = apply

  variables {
    talos_version = "v1.11.3"
  }

  assert {
    condition     = length(keys(yamldecode(talos_image_factory_schematic.this.schematic).customization)) == 0
    error_message = "Without options the schematic must have an empty customization."
  }

  assert {
    condition     = output.iso_url == "https://factory.example/image.iso" && output.installer_image == "factory.example/installer:v1.11.3"
    error_message = "Without SecureBoot the outputs must return the standard variants."
  }
}

run "extensions_and_kernel_args" {
  command = plan

  variables {
    talos_version     = "v1.11.3"
    platform          = "nocloud"
    extensions        = ["siderolabs/qemu-guest-agent", "siderolabs/iscsi-tools"]
    extra_kernel_args = ["net.ifnames=0"]
  }

  override_data {
    target = data.talos_image_factory_extensions_versions.this[0]
    values = {
      extensions_info = [
        { name = "siderolabs/qemu-guest-agent", author = "Sidero Labs", description = "mock", digest = "sha256:0", ref = "mock" },
        { name = "siderolabs/iscsi-tools", author = "Sidero Labs", description = "mock", digest = "sha256:1", ref = "mock" },
      ]
    }
  }

  assert {
    condition     = yamldecode(talos_image_factory_schematic.this.schematic).customization.systemExtensions.officialExtensions == ["siderolabs/iscsi-tools", "siderolabs/qemu-guest-agent"]
    error_message = "Extensions must be written sorted in the schematic."
  }

  assert {
    condition     = yamldecode(talos_image_factory_schematic.this.schematic).customization.extraKernelArgs == ["net.ifnames=0"]
    error_message = "Kernel arguments must be written in the schematic."
  }
}

run "unknown_extension" {
  command = plan

  variables {
    talos_version = "v1.11.3"
    extensions    = ["siderolabs/does-not-exist"]
  }

  override_data {
    target = data.talos_image_factory_extensions_versions.this[0]
    values = {
      extensions_info = []
    }
  }

  expect_failures = [data.talos_image_factory_extensions_versions.this[0]]
}

run "secureboot_variants" {
  command = apply

  variables {
    talos_version = "v1.11.3"
    secureboot    = { enabled = true }
  }

  assert {
    condition     = output.iso_url == "https://factory.example/image-secureboot.iso" && output.installer_image == "factory.example/installer-secureboot:v1.11.3"
    error_message = "With secureboot.enabled the outputs must return the SecureBoot variants."
  }

  assert {
    condition     = length(keys(yamldecode(talos_image_factory_schematic.this.schematic).customization)) == 0
    error_message = "secureboot.enabled alone must not change the schematic."
  }
}

run "secureboot_options_in_schematic" {
  command = plan

  variables {
    talos_version = "v1.11.3"
    secureboot = {
      enabled                         = true
      enroll_keys                     = "force"
      include_well_known_certificates = true
    }
  }

  assert {
    condition     = yamldecode(talos_image_factory_schematic.this.schematic).customization.secureboot.enrollKeys == "force"
    error_message = "enroll_keys must be written in the schematic."
  }

  assert {
    condition     = yamldecode(talos_image_factory_schematic.this.schematic).customization.secureboot.includeWellKnownCertificates == true
    error_message = "include_well_known_certificates must be written in the schematic."
  }
}
