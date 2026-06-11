variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API Endpoint"
}

variable "proxmox_username" {
  type        = string
  description = "Proxmox username, for example root@pam"
}

variable "proxmox_api_token" {
  type        = string
  description = "Proxmox API token secret"
  sensitive   = true
}


variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node where the VM will be created"
}

variable "vm_datastore_id" {
  type        = string
  description = "Datastore used for the VM disk"
}

variable "snippet_datastore_id" {
  type        = string
  description = "Datastore used for cloud-init snippets"
}

variable "network_bridge" {
  type        = string
  description = "Proxmox network bridge for the VM"
}

variable "ministack_vm_id" {
  type        = number
  description = "VM ID for the MiniStack VM"
}

variable "ministack_vm_name" {
  type        = string
  description = "Name of the MiniStack VM"
}

variable "ubuntu_cloud_image_url" {
  type        = string
  description = "URL of the Ubuntu cloud image to download"
}

variable "ubuntu_cloud_image_file_name" {
  type        = string
  description = "File name for the Ubuntu cloud image in Proxmox"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected into the MiniStack VM"
}

variable "proxmox_ssh_username" {
  type        = string
  description = "SSH username used by the provider to connect to the Proxmox node"
}