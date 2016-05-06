#!/bin/bash

## Variables
version=$(cat /home/vagrant/.vbox_version)
tempdir="/tmp/virtualbox"
vboxga_run="/tmp/virtualbox/VBoxLinuxAdditions.run"
vbxga_iso="/home/vagrant/VBoxGuestAdditions_$version.iso"

### Functions
vbox_ga() {
  mkdir "$tempdir"
  mount -o loop "$vbxga_iso" "$tempdir"
  sh "$vboxga_run"
  umount "$tempdir"
  rmdir "$tempdir"
  rm "$vbxga_iso"
}

### Script
set -x
vbox_ga
