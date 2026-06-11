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