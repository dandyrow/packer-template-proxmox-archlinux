data "sshkey" "archlinux" {}

source "proxmox" "archlinux" {
  # Proxmox host specific settings
  proxmox_url              = "https://${var.proxmox_host}/api2/json"
  insecure_skip_tls_verify = var.skip_tls
  username                 = var.proxmox_api_token_id
  password                 = local.use_password ? var.proxmox_api_password : null
  token                    = local.use_password ? null : var.proxmox_api_token_secret
  node                     = var.proxmox_node

  # ISO settings
  iso_url          = "https://mirror.rackspace.com/archlinux/iso/latest/archlinux-x86_64.iso"
  iso_storage_pool = var.iso_storage_pool
  iso_checksum     = "sha256:de301b9f18973e5902b47bb00380732af38d8ca70084b573ae7cf36a818eb84c" # If downloading should be updated to latest before running packer build
  unmount_iso      = true

  additional_iso_files {
    device           = "scsi5"
    iso_storage_pool = var.iso_storage_pool
    unmount          = true
    cd_content = {
      meta-data = jsonencode("")
      user-data = templatefile("${path.root}/templates/user-data.pkrtpl", { ssh_public_key = data.sshkey.archlinux.public_key })
    }
    cd_label = "cidata"
  }

  # VM config settings
  vm_id                = 900
  vm_name              = "archlinux"
  template_description = "Base install of arch linux with vim, doas, qemu-guest-agent, and sane security defaults setup"
  os                   = "l26"
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

  # EFI boot partition
  disks {
    type              = "virtio"
    disk_size         = "100M"
    storage_pool      = var.storage_pool
    storage_pool_type = var.storage_pool_type
  }

  disks {
    type              = "virtio"
    disk_size         = "10G"
    storage_pool      = var.storage_pool
    storage_pool_type = var.storage_pool_type
  }

  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  # Packer ssh settings
  ssh_username              = "arch"
  ssh_private_key_file      = data.sshkey.archlinux.private_key_path
  ssh_clear_authorized_keys = true
}