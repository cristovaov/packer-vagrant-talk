#!/bin/bash

## Functions
zero_disk() {
  dd if=/dev/zero of=/EMPTY bs=1M
  sync
  rm -f /EMPTY
  sync
  sync
}

### Script
set -x
zero_disk
