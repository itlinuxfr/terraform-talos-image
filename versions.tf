terraform {
  required_version = ">= 1.9"

  # A module declares a lower bound only: the live repository pins exact versions.
  # 0.12.0 is the oldest version checked for exact_filters and the architecture argument.
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.12.0"
    }
  }
}
