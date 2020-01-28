# vagrant-kube

All Vagranfiles that I'm using currently. Just follow the instructions below:

## Initial Setup
In order to first installation of Virtual Box and Vagrant, just run the command below:

    git clone https://github.com/salehsedghpour/vagrant-files
    cd vagrant-files
    sudo sh initial_setup.sh
**Note:** this will install Virtual Box v6.0 and Vagrant v2.2.6 on Ubuntu Bionic

## Setup kubernetes
In order to create a Kubernetes cluster with 1 master and 2 workers, just run the command below:

    cd kubernetes
    vagrant up
**Details:** for more details please read [this](https://github.com/salehsedghpour/vagrant-files/tree/master/kubernetes)
