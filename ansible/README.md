# Ansible Configuration Management for Jenkins Server

This directory contains production-ready Ansible playbooks and modular roles to automatically configure the Jenkins EC2 instance provisioned by Terraform.

## Installed Tools & Stack
- **Java:** OpenJDK 17 LTS (required for Jenkins CI and Spring Boot)
- **Jenkins:** Jenkins LTS server (port 8080)
- **Docker:** Docker CE runtime + containerd (`jenkins` user added to `docker` group)
- **Trivy:** Aqua Security vulnerability scanner for container security checks

## Ansible Roles
1. `common`: System updates and fundamental dependencies (`curl`, `git`, `jq`, `unzip`, `ca-certificates`).
2. `java`: Java OpenJDK installation and `JAVA_HOME` configuration.
3. `docker`: Docker CE installation, service activation, and permission granting.
4. `trivy`: Trivy container vulnerability scanner setup.
5. `jenkins`: Jenkins LTS repository registration, installation, service activation, and readiness probe.

## Dynamic Inventory
- **`inventory/aws_ec2.yml`**: AWS EC2 dynamic inventory plugin filtering by `tag:Project: ivolve` and `tag:Role: jenkins`.
- **`inventory/floci_inventory.py`**: Custom script compatible with Floci local cloud emulator and local test runs.
- **`inventory/hosts.ini`**: Static inventory fallback for direct IP testing.

## Execution

```bash
cd ansible

# Make dynamic inventory executable
chmod +x inventory/floci_inventory.py

# Run playbook with dynamic inventory
ansible-playbook -i inventory/aws_ec2.yml playbook.yml

# Or with static inventory
ansible-playbook -i inventory/hosts.ini playbook.yml
```
