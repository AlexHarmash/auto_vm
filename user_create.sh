#!bin/bash

mkdir -p $HOME/kvm/vm2

#<==============Created VM====================>

qemu-img create -F qcow2 -b ~/kvm/base/focal-server-cloudimg-amd64.img \
-f qcow2 ~/kvm/vm2/vm2.qcow2 10G

cloud-localds -v --network-config=data/network-config \
~/kvm/vm2/vm2-seed.qcow2 data/user-data data/meta-data

sudo virt-install --connect qemu:///system --virt-type kvm --name vm2 --ram \
2048 --vcpus=2 --os-type linux --os-variant ubuntu20.04 --disk \
path=$HOME/kvm/vm2/vm2.qcow2,device=disk \
--disk path=$HOME/kvm/vm2/vm2-seed.qcow2,device=disk \
--import --network network=default,model=virtio,mac=52:54:00:95:36:86 --noautoconsole

#<==============----------====================>