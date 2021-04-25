#!bin/bash

#<==============update and install packedge====================>

sudo apt update
sudo apt install -y qemu-kvm \
                    libvirt-daemon-system \
                    bridge-utils \
                    virtinst \
                    cloud-image-utils

#<==============----------------------------====================>

sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER


