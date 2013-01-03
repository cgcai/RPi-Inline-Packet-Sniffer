#!/bin/bash
addresses=$(ifconfig eth0 | grep "inet addr" | sed "s/^ *//;s/ *$//;s/ \    {1,\}/ /g;s/inet addr://;s/Bcast://;s/Mask://")

eth_ip=$(echo $addresses | cut -d' ' -f1)
eth_broadcast=$(echo $addresses | cut -d' ' -f2)
eth_netmask=$(echo $addresses | cut -d' ' -f3)

default_gw=$(ip route show default | grep "default" | cut -d' ' -f3)

brctl addbr sniff0
brctl addif sniff0 eth0
brctl addif sniff0 eth1

ifconfig eth0 0.0.0.0 promisc up
ifconfig eth1 0.0.0.0 promisc up

ifconfig sniff0 $eth_ip netmask $eth_netmask broadcast $eth_broadcast promisc up
route add default gw $default_gw sniff0

tcpdump -i eth1 -C 100 -W 10 -w pcap
