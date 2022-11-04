source "proxmox" "archlinux" {
  # Proxmox host specific settings
  proxmox_url = "https://${var.proxmox_host}/api2/json"
  username    = var.proxmox_api_token_id
  password    = local.use_password ? var.proxmox_api_password : null
  token       = local.use_password ? null : var.proxmox_api_token_secret
  node        = var.proxmox_node

  # ISO settings
  iso_url          = "https://mirror.rackspace.com/archlinux/iso/latest/archlinux-x86_64.iso"
  iso_storage_pool = var.iso_storage_pool
  iso_checksum     = "sha256:df6749df55b02cec98e5a9177c7957acfb96fe14d04553b6e4714100a4824f68" # If downloading should be updated to latest before running packer build

  # VM config settings
  vm_id                = 900
  vm_name              = "archlinux"
  template_description = "Base install of arch linux with vim, doas, qemu-guest-agent, and sane security defaults setup"
  os                   = "l26"
  unmount_iso          = true
  qemu_agent           = true

  # VM hardware settings
  memory   = 1024
  cores    = 1
  cpu_type = "host"
  machine  = "q35"
  bios     = "ovmf"

  vga {
    type   = "virtio"
    memory = 32
  }

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  scsi_controller = "virtio-scsi-pci"
  efidisk         = var.storage_pool

  disks {
    type              = "virtio"
    disk_size         = "10G"
    storage_pool      = var.storage_pool
    storage_pool_type = var.storage_pool_type
  }

  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  # Packer provisioner settings
  http_directory = "./http"
  ssh_username   = var.ssh_username
}