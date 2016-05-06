#!/bin/bash

## Variables
ssh_dir="/home/vagrant/.ssh"
auth_key="/home/vagrant/.ssh/authorized_keys"
key_url="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub"

### Functions
vagrant_key() {
  mkdir -p "$ssh_dir"
  chmod 0700 "$ssh_dir"
  wget --no-check-certificate "$key_url" -O "$auth_key"
  chmod 0600 "$auth_key"
  chmod go+r "$auth_key"
  chown -Rf vagrant:vagrant "$ssh_dir"
}

### Script
set -x
vagrant_key
