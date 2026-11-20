#!/bin/bash
# Bootstrapping script for Jenkins EC2 Instance
set -e

echo "=== Updating packages ==="
apt-get update -y

echo "=== Installing prerequisites ==="
apt-get install -y apt-transport-https ca-certificates curl software-properties-common git

echo "=== Node is provisioned and ready for Ansible configuration ==="
