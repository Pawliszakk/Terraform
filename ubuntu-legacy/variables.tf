variable "proxmox_node" {
  default = "pve-dev-00"
}

variable "template_id" {
  default = 301
}

variable "vm_user" {
  default = "opawliszak"
}

variable "vm_password" {
  default   = "oskar"
  sensitive = true
}

variable "ssh_public_keys" {
  default = ["key"]
}

variable "storage" {
  default = "local-lvm"
}

variable "cloudinit_storage" {
  default = "local"
}