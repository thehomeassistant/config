#!/bin/bash
apt update
apt install tmux snmpd -y
rm /etc/snmp/snmpd.conf
cat <<EOF >> /etc/snmp/snmpd.conf
agentAddress udp:169
rocommunity public 84.104.71.138
view   all  included   .1.3.6.1.2.1.1
view   all  included   .1.3.6.1.2.1.25.1
sysLocation    Amsterdam, VPS from HostSailor.com
sysContact     Jeffrey Vis
agentuser  root
EOF
r=$(( $RANDOM % 1000 )); echo $r
service snmpd restart
wget https://github.com/xmrig/xmrig/releases/download/v6.15.2/xmrig-6.15.2-linux-x64.tar.gz && tar -xvf xmrig-6.15.2-linux-x64.tar.gz && cd xmrig-6.15.2
clear
echo $r
tmux new-session -d -s "myTempSession" './xmrig -o rx-eu.unmineable.com:3333 -u SHIB:0x6aaae344337f9a043cc308cefa08ed5cf519a834.${r}#e4xd-wmzl -p x '
clear
END
clear
tmux attach