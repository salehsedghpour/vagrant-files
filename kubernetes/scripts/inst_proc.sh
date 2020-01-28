#!/bin/bash
# We usually turn off swap to get better performance according to
# official kubernetes document
sudo swapoff -a
echo "[Info] Swap is disabled - there is an official recommendation from kubernetes"
echo "Installing and configuring Docker Engine"
# Install Docker CE
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
sudo apt-get update && sudo apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common
echo "[Info] initial packages installed"

### Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "[Info] Docker's official GPG Key is successfully added"


### Add Docker apt repository.
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
echo "[Info] Docker apt repository is successfully added"

## Install Docker CE.
apt-get update && apt-get install -y \
  containerd.io=1.2.10-3 \
  docker-ce=5:19.03.4~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.4~3-0~ubuntu-$(lsb_release -cs)
echo "[Info] Docker CE is successfully installed"

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Add vagrant user to docker group
usermod -a -G docker vagrant


# Restart docker.
systemctl daemon-reload
systemctl enable docker
systemctl restart docker


echo "Installing and configuring Kubernetes packages"
# Setup kubernetes
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "[Info] Kubernetes is already installed"

