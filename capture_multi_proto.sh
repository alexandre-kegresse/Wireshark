#!/bin/bash

# Interface réseau à utiliser (à adapter si nécessaire)
INTERFACE="wlp2s0"

# Répertoire de sortie
OUTDIR="captures_tshark"
mkdir -p "$OUTDIR"

echo "[+] Début des captures..."

# Capture DNS
tshark -i "$INTERFACE" -f "udp port 53" -c 50 -w "$OUTDIR/dns.pcapng"

# Capture DHCP (port 67/68)
tshark -i "$INTERFACE" -f "port 67 or port 68" -c 30 -w "$OUTDIR/dhcp.pcapng"

# Capture TLS
tshark -i "$INTERFACE" -f "tcp port 443" -c 30 -w "$OUTDIR/tls.pcapng"

# Capture SMB
tshark -i "$INTERFACE" -f "tcp port 445" -c 30 -w "$OUTDIR/smb.pcapng"

# Capture mDNS
tshark -i "$INTERFACE" -f "udp port 5353" -c 30 -w "$OUTDIR/mdns.pcapng"

# Capture FTP (en clair sur port 21)
tshark -i "$INTERFACE" -f "tcp port 21" -c 30 -w "$OUTDIR/ftp.pcapng"

echo "[+] Captures terminées. Fichiers disponibles dans : $OUTDIR/"
