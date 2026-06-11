resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = var.vm_datastore_id
  node_name    = var.proxmox_node_name

  file_name = var.ubuntu_cloud_image_file_name
  url       = var.ubuntu_cloud_image_url
}

resource "proxmox_virtual_environment_vm" "ministack" {
  name      = var.ministack_vm_name
  node_name = var.proxmox_node_name
  vm_id     = var.ministack_vm_id

  cpu {
    cores = 2
    type  = "host"
  }
  memory {
    dedicated = 4096
  }

  agent {
    enabled = true
  }

  disk {
    datastore_id = var.vm_datastore_id
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "scsi0"
    size         = 40
  }

  initialization {
    datastore_id = var.vm_datastore_id
    user_account {
      username = "ubuntu"
      keys     = [var.ssh_public_key]
    }
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  network_device {
    bridge = var.network_bridge
  }

  operating_system {
    type = "l26"
  }
  serial_device {}

}


output "ministack_vm_id" {
  value = proxmox_virtual_environment_vm.ministack.vm_id
}

output "ministack_vm_name" {
  value = proxmox_virtual_environment_vm.ministack.name
}
