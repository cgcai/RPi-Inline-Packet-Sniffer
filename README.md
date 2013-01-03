rpi-inline-sniffer
==================

Inline Packet Sniffer on Raspberry Pi
#Requirements
An additional compatible network adaptor (`eth1`) to the onboard ethernet port (`eth0`).
#Installation
From a fresh install of Raspbian Wheezy, you need to install the following packages:

* tcpdump
* bridge-utils

`sudo apt-get install tcpdump bridge-utils`
#Running
`sudo ./start.sh` will bridge `eth0` and `eth1` as `sniff0`, and listen to packets on `eth1`. The script also copies the default gateway ( *and only the default gateway!* ) from `eth0` to `sniff0`.

Currently, tcpdump is run with the following arguments:

`tcpdump -i eth1 -s 0 -C 100 -W 10 -w pcap`

To stop capturing, press `Ctrl + C`.

`sudo ./end.sh` will restore the ip4 address, netmask, broadcast, and default gateway of `eth0`.
#Future Direction
1. Parameterize network interfaces, names, and tcpdump arguments.
2. Add more options for copying rules from `route`.