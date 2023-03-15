variable proxmox_api {}
variable proxmox_user {}
variable proxmox_token {}

variable "proxmox_node" {
    type = string
    default = "think-01"
}

variable "lxc_template" {
    type = string
    default = "local:vztmpl/fedora-37-default_20221119_amd64.tar.xz"
}

variable "container_password" {}