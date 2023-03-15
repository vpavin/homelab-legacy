terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.13"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_api
  pm_api_token_id = var.proxmox_user
  pm_api_token_secret = var.proxmox_token
  pm_tls_insecure = true
}

resource "proxmox_lxc" "k3s-masters" { 
    count = 2
    vmid = count.index + 100
    hostname = "k3s-master-${count.index + 1}"
    cores = 4
    memory = "2048"
    swap = "512"

    network {
        name = "eth0"
        bridge = "vmbr0"
        ip = "192.168.0.${count.index + 100}/24"  
        firewall = true
    }

    rootfs {
        storage = "local-lvm"
        size    = "16G"
    }

    ostemplate = var.lxc_template
    password = var.container_password
    target_node = var.proxmox_node
    unprivileged = true
}

resource "proxmox_lxc" "k3s-workers" { 
    count = 4
    vmid = count.index + 200
    hostname = "k3s-workers-${count.index + 1}"
    cores = 4
    memory = "4096"
    swap = "1024"

    network {
        name = "eth0"
        bridge = "vmbr0"
        ip = "192.168.0.${count.index + 200}/24"  
        firewall = true
    }

    rootfs {
        storage = "local-lvm"
        size    = "16G"
    }

    ostemplate = var.lxc_template
    password = var.container_password
    target_node = var.proxmox_node
    unprivileged = true
}

resource "proxmox_lxc" "postgres-0" { 
    vmid = 800
    hostname = "postgres-0"
    cores = 2
    memory = "2048"
    swap = "1024"

    network {
        name = "eth0"
        bridge = "vmbr0"
        ip = "192.168.0.50/24"  
        firewall = true
    }

    rootfs {
        storage = "local-lvm"
        size    = "50G"
    }

    ostemplate = var.lxc_template
    password = var.container_password
    target_node = var.proxmox_node
    unprivileged = true
}