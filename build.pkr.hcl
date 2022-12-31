build {
  name = "Proxmox Arch Linux"
  sources = [
    "source.proxmox.archlinux"
  ]
  provisioner "ansible" {
    playbook_file = "./ansible/arch_install.yml"
    use_proxy = false
  }
  provisioner "shell" {
    inline = [
      "sudo ansible-galaxy collection install community.general",
      "sudo ansible-galaxy install -r /tmp/config_playbook/requirements.yml",
      "sudo ansible-playbook -c chroot -i /tmp/config_playbook/inventory /tmp/ansible_config/arch_install.yml"
    ]
  }
}