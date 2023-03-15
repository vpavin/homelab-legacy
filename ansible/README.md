# Homelab VM Configuration (Ansible)

Ansible configuration files for VMs generated with Terraform.

## Prerequisites

- The virtual machines must be provided before running the playbooks through terraform plan;
- This playbook vars (database password and sensitive information) is protected by Ansible Vault. Run the playbooks with the `--ask-vault-password` option;
- Update the sensitive information on `vars/main.yml` if the Vault password is missing.

## Inventory

Datacenter inventory is available on [inventory](./inventory) file.

## Roles

### Postgres

Role responsible to configure a Postgres instance to hold Kubernetes control plane configuration.

- User: kube
- Database: kube

## Running playbook

To run the playbook to entire infrastructure execute: 

```bash
> ansible-playbook -i inventory site.yml --ask-vault-pass
```