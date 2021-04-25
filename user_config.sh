#!bin/bash

#<==============Configuration VM====================>

 cat >data/network-config <<EOF
ethernets:
    eno1:
        addresses: 
        - 192.168.8.12/24
        dhcp4: false
        gateway4: 192.168.1.1
        match:
            macaddress: 52:54:00:95:36:86
        nameservers:
            addresses: 
            - 1.1.1.1
            - 8.8.8.8
        set-name: eno1
version: 2
EOF

 cat >data/user-data <<EOF
#cloud-config
hostname: vm2
manage_etc_hosts: true
users:
  - name: vm2
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/vm2
    shell: /bin/bash
    lock_passwd: false
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    vm2:vm2
  expire: false
EOF

touch data/meta-data

#<==============------------------====================>