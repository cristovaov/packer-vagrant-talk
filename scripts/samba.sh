#!/bin/bash

# Samba provisioning:
# Provides a work-around for Windows users dir characters restrictions
# by installing Samba. You'll have to map a network drive manually though.
# defaults -- user: vagrant password: vagrant
# -- map address: \\tenderloin\

## Variables
srvdir="/home/vagrant"
user="vagrant"
group="vagrant"
mypass="vagrant"
conf_path="/etc/samba/smb.conf"

### Functions
samba_install() {
  apt-get update -q -y
  apt-get install -y samba
  (echo $mypass; echo $mypass) | smbpasswd -as "$user"
  SMBCONF=$(cat << 'EOF'
[homes]
comment = Home Directories
available = yes
valid users = %S
read only = no
browseable = yes
public = yes
writable = yes
create mask = 0777
directory mask = 0777
EOF
)
  echo "${SMBCONF}" >> "$conf_path"
  restart smbd
  testparm -s
}

srv_dir() {
  mkdir -p "$srvdir"
  chown -Rf "$user:$group" "$srvdir"
  find "$srvdir" -type d -print0 | xargs -0 chmod 775 "$srvdir"
  find "$srvdir" -type f -print0 | xargs -0 chmod 774 "$srvdir"
  chmod u+s "$srvdir"
  chmod g+s "$srvdir"
}

### Script - calling our functions
set -x
srv_dir
samba_install
