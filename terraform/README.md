# Homelab VM Infrastructure (Terraform)

Terraform plan to create a Kubernetes (K3s) cluster and support services.

## Provided VMs

ID | Node | IP Address | Description
-- | -- | -- | -- 
10[1-2] | **k3s-master-[1-2]** | 192.168.1.100[1-2] | Lightweight Kubernetes (K3s) master nodes
20[1-4] | **k3s-worker-[1-2]** | 192.168.1.200[1-2] | Lightweight Kubernetes (K3s) worker nodes
800 | **postgres-0** | 192.168.1.50 | PostgresSQL service - for kubernetes control plane storage

## Instructions

1. Log on the Proxmox server and create a new API user on the internal PVE authentication server, provide proper access level:
   1. On Datacenter > Permissions > Users click on Add;
   2. Provide a name (such terraform), select Proxmox VE authentication server as Realm and click on Add;
   3. On Datacenter > Permissions > API Tokens, click on Add;
   4. Select the created user (terraform on this case) and create a name for the token (such as token), click on Add;
   5. On Datacenter > Permissions, add the following permissions:
      1. User permission: Path: /, User: [created user], Role: PVEVMADmin, Propagate: yes
      2. User permission: Path: /storage/local-lvm, User: [created user], Role: Administrator, Propagate: yes
      3. API Token permission: Path: /, User: [created user], Role: PVEVMADmin, Propagate: yes
2. Copy the file `template.tfvars` as `terraform.tfvars` and provide the required parameters;
3. For `proxmox_user` use the pattern `[user]@pve![token_id]` - see below example

        ```ini
        proxmox_api = "https://192.168.0.10:8006/api2/json"
        proxmox_user = "terraform@pve!token"
        proxmox_token = "bd575435-1b7e-41e9-8a18-f41aecb611c8"
        container_password = "passw0rd"
        ```

4. Run the terraform commands to apply changes:

```bash
> terraform init
> terraform plan
> terraform apply
```

> Finish LXC containers with Ansible roles.