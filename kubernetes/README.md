# Setup Kubernetes Cluster
This Vagrantfile will provision a Kubernetes cluster with one master and _n_
worker nodes (2 by default).


## Prerequisites
1. Install Virtual Box using [previous page](https://github.com/salehsedghpour/vagrant-files) initial setup.
1. Install Vagrant using [previous page](https://github.com/salehsedghpour/vagrant-files) initial setup.

## Quick start
1. Clone this repository `git clone https://github.com/salehsedghpour/vagrant-files`
1. Change into the `vagrant-files/kubernetes` folder
1. Run `vagrant up`

Your cluster is ready!  
Within the master guest (`vagrant ssh master`) you can check the status of the
cluster (as the `vagrant` user). E.g.:
- `kubectl cluster-info`
- `kubectl get nodes`
- `kubectl get pods --namespace=kube-system`


## About the Vagrantfile

The VMs communicate via a private network:

- Master node: 192.168.99.100 / master.vagrant.vm
- Worker node i: 192.168.99.(100+i) / worker_i_.vagrant.vm

The Vagrant provisioning script pre-loads Kubernetes and satisfies the
pre-requisites.
Unless you have a password-less [Local Registry](#local-registry) it does
**not** run `kubeadm-setup.sh`. This is done by the `kubeadm-setup-master.sh`
 and `kubeadm-setup-worker.sh` helper scripts.

## Configuration
The Vagrantfile can be used _as-is_; there are a couple of parameters you
can set to tailor the installation to your needs.

### How to configure
There are several ways to set parameters:
1. Update the Vagrantfile. This is straightforward; the downside is that you
will loose changes when you update this repository.

### Cluster parameters
- `NB_WORKERS` (default: 2): the number of worker nodes to provision.
- `BIND_PROXY` (default: `true`): when `true`, Vagrant will bind the Kubernetes
Proxy port from the master node to the host. Useful to access the
Dashboard or any other application from _outside_ the cluster.
It is an easier alternative to ssh tunnel.
- `MEMORY` (default: 2048): all VMs are provisioned with 2GB memory. This
can be slightly reduced if memory is a concern.


## Feedback
Please provide feedback of any kind via Github issues 
