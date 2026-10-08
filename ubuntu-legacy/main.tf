locals {
  k8s_nodes = {
    "controlplane"    = { vm_id = 401, ip = "172.20.15.170" }
    "node01" = { vm_id = 402, ip = "172.20.15.171" }
    "node02" = { vm_id = 403, ip = "172.20.15.172" }
  }
}

resource "proxmox_virtual_environment_vm" "k8s_node" {
  for_each  = local.k8s_nodes
  node_name = var.proxmox_node
  vm_id     = each.value.vm_id
  name      = each.key
  on_boot   = true


  agent {
    enabled = false
  }
  clone {
    vm_id = var.template_id
    full  = true
  }

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 8192
  }

  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    size         = 32
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    datastore_id = var.cloudinit_storage

    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "172.20.15.254"
      }
    }

    user_account {
      username = "opawliszak"
      password = var.vm_password
      keys     = var.ssh_public_keys
    }
  }
}