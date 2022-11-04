locals {
  use_password = var.proxmox_password != null ? true : false
  use_iso_file = var.iso_file != null ? true : false
}