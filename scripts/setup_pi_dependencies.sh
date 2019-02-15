#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

PI_HOSTNAME=pi-local
PACKAGES="python3-pip supervisor"

ssh ${PI_HOSTNAME} "sudo /bin/bash -c 'apt-get clean && apt-get update && apt-get install -y ${PACKAGES} && pip3 install pipenv'"
