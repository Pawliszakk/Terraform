resource "proxmox_virtual_environment_vm" "rocky-fleet" {
  for_each  = var.vms
  name      = each.key
  node_name = each.value.node

  clone {
    vm_id = var.templates[each.value.node]
    full  = true
  }

  cpu {
    cores = each.value.cores
    type  = "x86-64-v3"
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = each.value.disk_size
    iothread     = true
  }

  network_device {
    bridge = "vmbr0"
  }

  agent {
    enabled = false
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "172.20.1.254"
      }
    }
    user_account {
      username = var.vm_user
      password = var.vm_password
      keys     = var.ssh_public_keys
    }
  }
}