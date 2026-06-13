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
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.ministack_cloud_init_user_data.id
  }

  network_device {
    bridge = var.network_bridge
  }

  operating_system {
    type = "l26"
  }
  serial_device {}

}

resource "proxmox_virtual_environment_file" "ministack_cloud_init_user_data" {
  content_type = "snippets"
  datastore_id = var.snippet_datastore_id
  node_name    = var.proxmox_node_name

  source_raw {
    file_name = "ministack-user-data.yaml"
    data = templatefile(
      "${path.module}/cloud-init/ministack-user-data.yaml.tftpl",
      {
        hostname       = var.ministack_vm_name,
        ssh_public_key = trimspace(var.ssh_public_key),

      }
    )
  }
}


output "ministack_vm_id" {
  value = proxmox_virtual_environment_vm.ministack.vm_id
}

output "ministack_vm_name" {
  value = proxmox_virtual_environment_vm.ministack.name
}
