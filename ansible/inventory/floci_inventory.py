#!/usr/bin/env python3
"""
Custom Dynamic Inventory Script for Floci / AWS EC2
Returns JSON structure adhering to Ansible dynamic inventory standard.
"""
import json
import os
import sys
import urllib.request

FLOCI_ENDPOINT = os.environ.get("FLOCI_ENDPOINT", "http://localhost:4566")

def get_inventory():
    inventory = {
        "_meta": {
            "hostvars": {}
        },
        "all": {
            "children": ["jenkins_servers", "ungrouped"]
        },
        "jenkins_servers": {
            "hosts": []
        }
    }

    # Default fallback / local emulator instance
    default_host = os.environ.get("JENKINS_HOST", "127.0.0.1")
    inventory["jenkins_servers"]["hosts"].append(default_host)
    inventory["_meta"]["hostvars"][default_host] = {
        "ansible_user": os.environ.get("ANSIBLE_USER", "ubuntu"),
        "ansible_connection": "ssh" if default_host != "127.0.0.1" else "local",
        "role": "jenkins",
        "project": "ivolve"
    }

    return inventory

if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == "--list":
        print(json.dumps(get_inventory(), indent=2))
    elif len(sys.argv) == 3 and sys.argv[1] == "--host":
        print(json.dumps({}))
    else:
        print(json.dumps(get_inventory(), indent=2))
