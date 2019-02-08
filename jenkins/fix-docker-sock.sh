#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Let jenkins user read/write Docker socket
echo "chmod'ing Docker Socket ..."
/bin/chmod a+rw /var/run/docker.sock

