terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.99.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  username  = var.proxmox_username
  api_token = var.proxmox_api_token

  insecure = true

  ssh {
    username = var.proxmox_ssh_username
    agent    = true
  }
}