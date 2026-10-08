variable "templates" {
  default = {
    pve-dev-00 = 9003
    pve-dev-01 = 9002
  }
}
variable "vms" {
  type = map(object({
    node      = string
    ip        = string
    cores     = number
    memory    = number
    disk_size = number
  }))
  default = {
    rocky-a3f9 = { node = "pve-dev-01", ip = "192.168.0.200", cores = 1, memory = 2048, disk_size = 15 }
    rocky-7bd2 = { node = "pve-dev-01", ip = "192.168.0.201", cores = 1, memory = 2048, disk_size = 15 }
    rocky-e41c = { node = "pve-dev-01", ip = "192.168.0.202", cores = 1, memory = 2048, disk_size = 15 }
    rocky-09ac = { node = "pve-dev-01", ip = "192.168.0.203", cores = 1, memory = 2048, disk_size = 15 }
    rocky-d7e5 = { node = "pve-dev-01", ip = "192.168.0.204", cores = 1, memory = 2048, disk_size = 15 }
    rocky-3a1b = { node = "pve-dev-01", ip = "192.168.0.205", cores = 1, memory = 2048, disk_size = 15 }
    rocky-f862 = { node = "pve-dev-01", ip = "192.168.0.206", cores = 1, memory = 2048, disk_size = 15 }
    rocky-6c0d = { node = "pve-dev-01", ip = "192.168.0.207", cores = 1, memory = 2048, disk_size = 15 }
    rocky-2b97 = { node = "pve-dev-01", ip = "192.168.0.208", cores = 1, memory = 2048, disk_size = 15 }
    rocky-8e53 = { node = "pve-dev-01", ip = "192.168.0.209", cores = 1, memory = 2048, disk_size = 15 }
    rocky-a15f = { node = "pve-dev-01", ip = "192.168.0.210", cores = 1, memory = 2048, disk_size = 15 }
    rocky-d3c8 = { node = "pve-dev-01", ip = "192.168.0.211", cores = 1, memory = 2048, disk_size = 15 }
    rocky-4f2a = { node = "pve-dev-01", ip = "192.168.0.212", cores = 1, memory = 2048, disk_size = 15 }
    rocky-b7e1 = { node = "pve-dev-01", ip = "192.168.0.213", cores = 1, memory = 2048, disk_size = 15 }
    rocky-0d69 = { node = "pve-dev-01", ip = "192.168.0.214", cores = 1, memory = 2048, disk_size = 15 }
    rocky-5d68 = { node = "pve-dev-00", ip = "192.168.0.215", cores = 1, memory = 2048, disk_size = 15 }
    rocky-c2e7 = { node = "pve-dev-00", ip = "192.168.0.216", cores = 1, memory = 2048, disk_size = 15 }
    rocky-1f84 = { node = "pve-dev-00", ip = "192.168.0.217", cores = 1, memory = 2048, disk_size = 15 }
    rocky-b930 = { node = "pve-dev-00", ip = "192.168.0.218", cores = 1, memory = 2048, disk_size = 15 }
    rocky-48cd = { node = "pve-dev-00", ip = "192.168.0.219", cores = 1, memory = 2048, disk_size = 15 }
    rocky-e6a0 = { node = "pve-dev-00", ip = "192.168.0.220", cores = 1, memory = 2048, disk_size = 15 }
    rocky-92fb = { node = "pve-dev-00", ip = "192.168.0.221", cores = 1, memory = 2048, disk_size = 15 }
    rocky-73ae = { node = "pve-dev-00", ip = "192.168.0.222", cores = 1, memory = 2048, disk_size = 15 }
    rocky-c64b = { node = "pve-dev-00", ip = "192.168.0.223", cores = 1, memory = 2048, disk_size = 15 }
    rocky-1a8d = { node = "pve-dev-00", ip = "192.168.0.224", cores = 1, memory = 2048, disk_size = 15 }
    rocky-e92c = { node = "pve-dev-00", ip = "192.168.0.225", cores = 1, memory = 2048, disk_size = 15 }
    rocky-3b07 = { node = "pve-dev-00", ip = "192.168.0.226", cores = 1, memory = 2048, disk_size = 15 }
    rocky-f5d4 = { node = "pve-dev-00", ip = "192.168.0.227", cores = 1, memory = 2048, disk_size = 15 }
    rocky-8a16 = { node = "pve-dev-00", ip = "192.168.0.228", cores = 1, memory = 2048, disk_size = 15 }
    rocky-d0e3 = { node = "pve-dev-00", ip = "192.168.0.229", cores = 1, memory = 2048, disk_size = 15 }
  }
}

variable "template_id" {
  type    = number
  default = 9002
}

variable "ssh_public_keys" {
  type = list(string)
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "vm_user" {
  type = string
}
