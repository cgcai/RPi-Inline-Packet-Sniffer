#!/bin/bash
addresses=$(ifconfig sniff0 | grep "inet addr" | sed "s/^ *//;s/ *$//;s/ \    {1,\}/ /g;s/inet addr://;s/Bcast://;s/Mask://")

eth_ip=$(echo $addresses | cut -d' ' -f1)
eth_broadcast=$(echo $addresses | cut -d' ' -f2)
eth_netmask=$(echo $addresses | cut -d' ' -f3)

default_gw=$(ip route show default | grep "default" | cut -d' ' -f3)

brctl delif sniff0 eth0
brctl delif sniff0 eth1

ifconfig sniff0 down
brctl delbr sniff0

ifconfig eth0 up
ifconfig eth0 $eth_ip netmask $eth_netmask broadcast $eth_broadcast
route add default gw $default_gw eth0
