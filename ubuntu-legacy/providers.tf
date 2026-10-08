terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.73"
    }
  }
}

provider "proxmox" {
  endpoint = "https://172.32.21.42:8006"
  # api_token = "root@pam!terraform=cokolwiek"
  # insecure  = true
    ssh {
    agent    = false
  #   username = "root"
  #   password = "pass"
  }
}


# export PROXMOX_VE_ENDPOINT="https://172.32.21.42:8006"
# export PROXMOX_VE_API_TOKEN='root@pam!terraform=421412415616-b9c9d44ec877'
# export PROXMOX_VE_SSH_USERNAME="root"
# export PROXMOX_VE_SSH_PASSWORD="test-pass"
# export PROXMOX_VE_INSECURE=true