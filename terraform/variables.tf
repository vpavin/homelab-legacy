variable proxmox_api {}
variable proxmox_user {}
variable proxmox_token {}

variable "proxmox_node" {
    type = string
    default = "think-01"
}

variable "lxc_template" {
    type = string
    default = "local:vztmpl/ubuntu-22.10-standard_22.10-1_amd64.tar.zst"
}

variable "container_password" {}
variable "ssh_public_keys" {}