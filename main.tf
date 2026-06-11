data "proxmox_virtual_environment_nodes" "list_nodes" {

}

output "all_nodes" {
  value = data.proxmox_virtual_environment_nodes.list_nodes.names
}
