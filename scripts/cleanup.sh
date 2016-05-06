#!/bin/bash

## Functions
apt_clean() {
  apt-get autoremove -y
  apt-get clean all -y
}

lease_clean() {
  rm /var/lib/dhcp/*
}

rule_clean() {
  rm /etc/udev/rules.d/70-persistent-net.rules
  mkdir /etc/udev/rules.d/70-persistent-net.rules
  rm -rf /dev/.udev/
  rm /lib/udev/rules.d/75-persistent-net-generator.rules
}
interface_sleep() {
  echo "pre-up sleep 2" >> /etc/network/interfaces
}

### Script
set -x
apt_clean
lease_clean
rule_clean
interface_sleep
