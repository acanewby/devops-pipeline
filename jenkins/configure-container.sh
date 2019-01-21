#!/bin/bash

# Let jenkins user read/write Docker socket
echo "chmod'ing Docker Socket ..."
/bin/chmod a+rw /var/run/docker.sock

# Run a loop so the command stays alive (or the container will exit)
while [ 1 ]
do
    sleep 5
done