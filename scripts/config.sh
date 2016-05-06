#!/bin/bash

## Variables
buildfile="/etc/vagrant_box_build_time"
vagrant_doer="/etc/sudoers.d/vagrant"
sshd_conf="/etc/ssh/sshd_config"

### Functions
build_time() {
  date > "$buildfile"
}

apt_update() {
  apt-get update -q -y
  apt-get upgrade -q -y
}

sudoless() {
  SDLS=$(cat << 'EOF'
# add vagrant user
vagrant ALL=(ALL) NOPASSWD:ALL
EOF
)
  echo "$SDLS" > "$vagrant_doer"
}

no_dns() {
  echo "UseDNS no" >> "$sshd_conf"
}


### SCRIPT
set -x
build_time
apt_update
sudoless
no_dns
