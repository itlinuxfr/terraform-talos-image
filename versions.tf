terraform {
  # 1.15 adds explicit type constraints on outputs, used in outputs.tf.
  required_version = ">= 1.15"

  # A module declares a lower bound only: the live repository pins exact versions.
  # 0.12.0 is the latest release at the time of writing: it adds disk_image_format and targets Talos 1.14.
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.12.0"
    }
  }
}
