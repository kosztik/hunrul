#!/bin/bash
# /usr/local/bin/iptables-restore-wrapper.sh
# Fájl elérési útja
FW_FILE="/root/fw/fw.conf"

# Ellenőrizze, hogy a fájl létezik-e
if [ ! -f "$FW_FILE" ]; then
    echo "Hiba: $FW_FILE nem található!" >&2
    exit 1
fi

# IPTables szabályok betöltése
iptables-restore < "$FW_FILE" || exit 1

# IPv6 kikapcsolása (ha nem használod)
ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP

echo "IPTables szabályok betöltve: $FW_FILE"
exit 0
