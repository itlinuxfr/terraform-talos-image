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
    talos_version = "v1.11.3"
    architecture  = "x86"
  }

  expect_failures = [var.architecture]
}

run "empty_kernel_argument" {
  command = plan

  variables {
    talos_version     = "v1.11.3"
    extra_kernel_args = ["quiet", " "]
  }

  expect_failures = [var.extra_kernel_args]
}

run "invalid_enroll_keys" {
  command = plan

  variables {
    talos_version = "v1.11.3"
    secureboot    = { enroll_keys = "always" }
  }

  expect_failures = [var.secureboot]
}
