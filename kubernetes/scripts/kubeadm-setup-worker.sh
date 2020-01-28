#!/bin/bash
#
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2018 Oracle and/or its affiliates. All rights reserved.
#
# Since: March, 2018
# Author: philippe.vanhaesendonck@oracle.com
# Description: Runs kubeadm-setup on worker nodes
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#

JoinCommand="/vagrant/join-command.sh"
LogFile="kubeadm-setup.log"
NoLogin=""

# Parse arguments
while [ $# -gt 0 ]
do
  case "$1" in
    "--no-login")
      NoLogin=1
      shift
      ;;
    *)
     echo "$0: Invalid parameter"
     exit 1
     ;;
  esac
done

if [ ${EUID} -ne 0 ]
then
  echo "$0: This script must be run as root"
  exit 1
fi

if [ "$0" = "${SUDO_COMMAND%% *}" ]
then
  echo "$0: This script should not be called directly with 'sudo'"
  exit 1
fi

if [ ! -f "${JoinCommand}" ]
then
  echo "$0: Token not found. Is the master already configured?"
  exit 1
fi


echo "$0: Setup Worker node"
# This will join the worker node to the cluster using the token in file
bash "${JoinCommand}"

echo "$0: Worker node ready"
