variable "proxmox_host" {
  type        = string
  description = "IP or domain name of Proxmox host"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "Username / token ID when authenticating to Proxmox, including the realm"
}

variable "proxmox_api_password" {
  type        = string
  description = "Password for the Proxmox user"
  default     = null
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "Token for authenticating API calls. Set to null and fill in proxmox_password if using a password"
}

variable "proxmox_node" {
  type        = string
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation"
}

variable "iso_storage_pool" {
  type        = string
  description = "Proxmox storage pool onto which to upload the ISO file"
  default     = "local"
}

variable "storage_pool" {
  type        = string
  description = "Name of the Proxmox storage pool to store the virtual machine disk on"
  default     = "local-lvm"
}

variable "storage_pool_type" {
  type    = string
  default = "lvm"

  validation {
    condition     = contains(["lvm", "lvm-thin", "zfspool", "cephfs", "rbd", "directory"], var.storage_pool_type)
    error_message = "The storage pool type must be either 'lvm', 'lvm-thin', 'zfspool', 'cephfs', 'rbd', or 'directory'."
  }
}

variable "ssh_username" {
  type        = string
  description = "Username to use to SSH into the created VM"
}

variable "ssh_public_key" {
  type        = list(string)
  description = "SSH public keys to use to SSH into the created VM"
}

variable "ssh_password" {
  type        = string
  description = "Password to use to SSH into the created VM"
  default     = ""
}
