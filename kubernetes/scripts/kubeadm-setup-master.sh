#!/bin/bash
#
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2018 Oracle and/or its affiliates. All rights reserved.
#
# Since: March, 2018
# Author: philippe.vanhaesendonck@oracle.com
# Description: Runs kubeadm-setup on the master node and save the token for
#              the worker nodes
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#

JoinCommand="/vagrant/join-command.sh"
LogFile="kubeadm-setup.log"
NoLogin=""


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

KubeadmOptions=""

# This will initialize  kubernetes cluster that should be ran with sudo
sudo kubeadm init --apiserver-advertise-address=192.168.99.100 --pod-network-cidr=10.244.0.0/16 
echo "$0: Copying admin.conf for vagrant user"
mkdir -p ~vagrant/.kube
cp /etc/kubernetes/admin.conf ~vagrant/.kube/config
chown vagrant: ~vagrant/.kube/config

echo "$0: Copying admin.conf into host directory"
sed -e 's/192.168.99.100/127.0.0.1/' </etc/kubernetes/admin.conf >/vagrant/admin.conf

sudo sysctl net.bridge.bridge-nf-call-iptables=1

echo "$0: Saving token for worker nodes"

# 'token list' doesn't provide token hash, we have re-issue a new token to
# capture the hash -- See https://github.com/kubernetes/kubeadm/issues/519
kubeadm token create --print-join-command 2>/dev/null > "${JoinCommand}"

echo "$0: Master node ready, run"
echo -e "\t/vagrant/scripts/kubeadm-setup-worker.sh"
echo "on the worker nodes"
# It will create network layer3 infrastructure for containers,
# this hould be ran without root, as here it will be ran with vagrant
su vagrant -c 'kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml'
