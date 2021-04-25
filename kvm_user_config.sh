#!bin/bash

base_ip=192.168.8.

for ((index=0; index < $1; index++))
do

export MAC_ADDR=$(printf '%02x:%02x:%02x' \
 $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))

sed -i '/NUM/d' user_conf.yaml
sed -i '/USER_NAME/d' user_conf.yaml
sed -i '/PASSWORD/d' user_conf.yaml
sed -i '/IP_ADDR/d' user_conf.yaml
sed -i '/MAC_ADDR/d' user_conf.yaml

sed -i -e '$a NUM: '$index''  user_conf.yaml
sed -i -e '$a USER_NAME: vm'$index''  user_conf.yaml
sed -i -e '$a PASSWORD: vm'$index''  user_conf.yaml
sed -i -e '$a IP_ADDR: '$base_ip''$(($2 + index))''  user_conf.yaml
sed -i -e '$a MAC_ADDR: '$MAC_ADDR''  user_conf.yaml

j2 -f yaml kvm_user_config.j2 user_conf.yaml > user_config.sh
j2 -f yaml kvm_user_create.j2 user_conf.yaml > user_create.sh

bash user_config.sh
bash user_create.sh

done
