#!/bin/bash
# Note that Virtual Box v6.0 is compatible with Vagran v2.2.6
# Installing Virtual Box v6.0, the bash above is written based on official Document
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee -a /etc/apt/sources.list.d/virt_box.list
echo "[Info] Virtuabl box successfully added to sources list \n"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox-6.0
echo "[Info] Virtual-Box v6.0 is successfully installed\n"

# Installing Vagrant v2.2.6, tha bash above is written based on official Document
sudo dpkg -i ./deb_files/vagrant_2.2.6.deb

echo "[Info] Vagrant v2.2.6 is successfully installed\n"
