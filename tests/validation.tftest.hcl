# Input validation tests: each rejected value must fail the plan on the right variable.

mock_provider "talos" {}

run "talos_version_without_v" {
  command = plan

  variables {
    talos_version = "1.11.3"
  }

  expect_failures = [var.talos_version]
}

run "invalid_architecture" {
  command = plan

  variables {
    talos_version = "v1.14.6"
    architecture  = "x86"
  }

  expect_failures = [var.architecture]
}

run "empty_kernel_argument" {
  command = plan

  variables {
    talos_version     = "v1.14.6"
    extra_kernel_args = ["quiet", " "]
  }

  expect_failures = [var.extra_kernel_args]
}

run "invalid_enroll_keys" {
  command = plan

  variables {
    talos_version = "v1.14.6"
    secureboot    = { enroll_keys = "always" }
  }

  expect_failures = [var.secureboot]
}

run "invalid_disk_image_format" {
  command = plan

  variables {
    talos_version     = "v1.14.6"
    disk_image_format = "iso"
  }

  expect_failures = [var.disk_image_format]
}

run "valid_disk_image_format_with_compression" {
  command = plan

  variables {
    talos_version     = "v1.14.6"
    disk_image_format = "raw.zst"
  }
}
