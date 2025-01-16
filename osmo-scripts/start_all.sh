#!/bin/bash

#Variablen 
mgw4msc="--title "MGW4MSC" wsl osmo-mgw -c /etc/osmocom/osmo-mgw-for-msc.cfg"
mgw4bsc="--title "MGW4BSC" wsl osmo-mgw -c /etc/osmocom/osmo-mgw-for-bsc.cfg"

hlr="--title "HLR" wsl osmo-hlr -c /etc/osmocom/osmo-hlr.cfg"
stp="--title "STP" wsl osmo-stp -c /etc/osmocom/osmo-stp.cfg"
bsc="--title "BSC" wsl osmo-bsc -c /etc/osmocom/osmo-bsc/osmo-bsc.cfg"
bts="--title "BTS" wsl osmo-bts-virtual -c /etc/osmocom/osmo-bts-virtual.cfg"
msc="--title "MSC" wsl osmo-msc -c /etc/osmocom/osmo-msc.cfg"

kamailio="--title "KAMAILIO" wsl kamailio -f /etc/osmocom/kamailio.cfg"
virtphy="--title "virtphy" wsl virtphy"
ms1="--title "MS1" wsl mobile -c /etc/osmocom/mobile.cfg"
ms2="--title "MS2" wsl mobile -c /etc/osmocom/mobile2.cfg"

ms1VTY="--title "MS1VTY" wsl telnet 127.0.0.1 4247"
ms2VTY="--title "MS2VTY" wsl telnet 127.0.0.2 4247"

hlrC="osmo-hlr"
stpC="osmo-stp"
bscC="osmo-bsc"
btsC="osmo-bts-virtual"
mscC="osmo-msc"
virtphyC="virtphy"
msC="mobile"
kamailioC="kamailio"
mgwC="osmo-mgw"

# Start all the basic components for a GSM-Network
wt.exe nt $hlr
sleep .2
wt.exe nt $stp
sleep .2
wt.exe nt $bsc
sleep .2
wt.exe nt $bts
sleep .2
wt.exe nt $msc
sleep 1

# Start the MediaGateWays
wt.exe nt $mgw4msc
wt.exe nt $mgw4bsc
sleep 1
#Start Kamailio -> Not completly sure yet
wt.exe nt $kamailio

#Start the MS
wt.exe nt $virtphy
sleep .5
wt.exe nt $ms1
sleep .5
wt.exe nt $ms2
sleep 5

#Start VTY Console for MS1 and MS2
wt.exe nt $ms1VTY
wt.exe nt $ms2VTY


#Tear everything down
set +x
echo
echo "Enter to killall"
read enter_to_close
killall $hlrC
killall $stpC
killall $bscC
killall $btsC
killall $mscC
killall $msC
sleep 2
killall $virtphyC
killall $mgwC
sudo killall $kamailioC
