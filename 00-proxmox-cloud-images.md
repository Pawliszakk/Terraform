# Proxmox: VM templates from cloud images (Ubuntu 26.04, Rocky 10)

Create each template once on the Proxmox node. Terraform then clones it
(`clone { vm_id = var.template_id }`) and cloud-init sets IP, user and SSH keys.

Assumes the images are already in `/root`:

- `/root/ubuntu-26.04-server-cloudimg-amd64.img` (qcow2 despite the extension)
- `/root/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2`

Check the storage name with `pvesm status` (below: `local-lvm`) and that the VMIDs are free (`qm list`).

## Create templates

Ubuntu (VMID 9001):

```bash
qm create 9001 --name ubuntu-26 --memory 2048 --cores 2 --cpu host \
  --bios ovmf --machine q35 \
  --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single --ostype l26
qm set 9001 --efidisk0 local-lvm:1,efitype=4m,pre-enrolled-keys=0
qm set 9001 --scsi0 local-lvm:0,import-from=/root/ubuntu-26.04-server-cloudimg-amd64.img
qm resize 9001 scsi0 15G
qm set 9001 --ide2 local-lvm:cloudinit
qm set 9001 --boot order=scsi0 --serial0 socket --vga std
qm template 9001
```

Rocky (VMID 9002):

```bash
qm create 9002 --name rocky-10 --memory 2048 --cores 2 --cpu host \
  --bios ovmf --machine q35 \
  --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single --ostype l26
qm set 9002 --efidisk0 local-lvm:1,efitype=4m,pre-enrolled-keys=0
qm set 9002 --scsi0 local-lvm:0,import-from=/root/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2
qm resize 9002 scsi0 15G
qm set 9002 --ide2 local-lvm:cloudinit
qm set 9002 --boot order=scsi0 --serial0 socket --vga std
qm template 9002
```

Do not start the VM before `qm template`: cloud-init would run and bake
machine-id and SSH host keys into the template.

Verify: `qm config 9001` should show `template: 1` and `scsi0: local-lvm:base-9001-disk-0`.

## Terraform

Set `template_id` to 9001 or 9002. Credentials are mandatory, the images have no default login:

```hcl
clone {
  vm_id = var.template_id
  full  = true
}

initialization {
  ip_config {
    ipv4 {
      address = "172.20.15.170/24"
      gateway = "172.20.15.254"
    }
  }
  user_account {
    username = "opawliszak"
    keys     = var.ssh_public_keys
  }
}
```

- Set `size` in `disk` (images are a few GB, cloud-init grows the partition on first boot).
- Keep `agent { enabled = false }` until `qemu-guest-agent` is installed in the guest.
- Add `wait_for_connection` in Ansible, first boot takes a while.

## Updating

Templates are never modified. A newer image means a new template (e.g. 9003) and a new `template_id`.

## Debug

```bash
qm cloudinit dump <vmid> user      # on the node: generated cloud-init config
cloud-init status --long           # in the guest
less /var/log/cloud-init-output.log
```

Notes: templates are per node unless disks are on shared storage. Rocky ships with SELinux enforcing (RKE2 needs `container-selinux` / `rke2-selinux`).




qm create 9004 --name ubuntu-26 --memory 2048 --cores 2 --cpu host \
  --bios ovmf --machine q35 \
  --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single --ostype l26
qm set 9004 --efidisk0 local-lvm:1,efitype=4m,pre-enrolled-keys=0
qm set 9004 --scsi0 local-lvm:0,import-from=/root/ubuntu-26.04-server-cloudimg-amd64.img
qm resize 9004 scsi0 15G
qm set 9004 --ide2 local-lvm:cloudinit
qm set 9004 --boot order=scsi0 --serial0 socket --vga std
qm template 9004
```

Rocky (VMID 9002):

```bash
qm create 9003 --name rocky-10 --memory 2048 --cores 2 --cpu host \
  --bios ovmf --machine q35 \
  --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single --ostype l26
qm set 9003 --efidisk0 local-lvm:1,efitype=4m,pre-enrolled-keys=0
qm set 9003 --scsi0 local-lvm:0,import-from=/root/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2
qm resize 9003 scsi0 15G
qm set 9003 --ide2 local-lvm:cloudinit
qm set 9003 --boot order=scsi0 --serial0 socket --vga std
qm template 9003