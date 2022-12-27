build {
  name = "Proxmox Arch Linux"
  sources = [
    "source.proxmox.archlinux"
  ]
  provisioner "ansible" {
    playbook_file = "./arch_install.yml"
    use_proxy = false
  }
}