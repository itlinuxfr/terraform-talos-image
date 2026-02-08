# Test 1: Generate a "Vanilla" image (without extensions)
# Verify that the conditional logic (the else {} block) works correctly.
run "generate_vanilla_image" {
  command = plan

  variables {
    talos_version          = "v1.9.0"
    talos_image_platform   = "nocloud"
    talos_image_extensions = []
  }

  assert {
    condition     = output.talos_image_url != ""
    error_message = "Talos image URL should not be empty."
  }
}

# Test 2: Generate an image with extensions
# Verify that the extensions data source call is made correctly.
run "generate_image_with_extensions" {
  command = plan

  variables {
    talos_version          = "v1.9.0"
    talos_image_platform   = "nocloud"
    talos_image_extensions = ["qemu-guest-agent"]
  }

  assert {
    condition     = output.talos_image_url != ""
    error_message = "Talos image URL should not be empty with extensions."
  }
}

# Test 3: Version validation (Must fail)
# Verify that regex blocks versions without 'v'.
run "validate_version_format" {
  command = plan

  variables {
    talos_version        = "1.9.0" # Missing 'v'
    talos_image_platform = "nocloud"
  }

  expect_failures = [var.talos_version]
}

# Test 4: Platform validation (Must fail)
# Verify that the platform list is respected.
run "validate_platform_enum" {
  command = plan

  variables {
    talos_version        = "v1.9.0"
    talos_image_platform = "windows" # Invalid
  }

  expect_failures = [var.talos_image_platform]
}
