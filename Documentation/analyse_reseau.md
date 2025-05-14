Analyse réseau avec Wireshark

Introduction

Wireshark est un analyseur de paquets réseau puissant permettant de capturer, visualiser et analyser les données qui circulent sur un réseau en temps réel. Il est utilisé pour la supervision réseau, le développement logiciel, et surtout en cybersécurité pour l'analyse d'attaques ou de communications suspectes.

Trame, paquet, segment : les différences

Dans le modèle OSI, ces termes correspondent à différentes couches :

Terme

Couche OSI

- Contenu principal

- Trame

Couche 2 - Liaison

- Adresses MAC, Ethernet

- Paquet

Couche 3 - Réseau

- Adresses IP

- Segment

Couche 4 - Transport

- Ports TCP/UDP, numéros de séquence

Chaque trame encapsule un paquet, qui encapsule un segment.

Formats de capture : PCAP et PCAPNG

.pcap : format historique, simple.

.pcapng : format plus moderne, avec métadonnées (interfaces, commentaires, statistiques).

Exemple de capture : Paquet ARP

Type : ARP Request

IP Source : 10.10.241.47

IP Destination (Who has) : 10.10.239.158

MAC Source : xx:xx:xx:xx:xx:xx

MAC Destination : ff:ff:ff:ff:ff:ff (broadcast)

Le paquet ARP est une requête envoyée en broadcast pour résoudre une adresse IP en adresse MAC.

Exemple de capture : UDP et mDNS

Protocole : UDP (port 51071 → 3490)

IP source : 10.10.0.187

IP destination : 10.10.255.255

D'autres paquets visibles dans la capture utilisent le protocole mDNS (équivalent de DNS mais local).

Exemple de capture : TCP et Handshake

Protocole : TCP (connexion vers HTTPS)

IP Source : 10.10.102.51

IP Destination : 34.223.124.45

Ports : 34940 → 443

Détail du Handshake TCP :

Client envoie SYN (synchronisation)

Serveur répond avec SYN + ACK

Client termine avec ACK

Connexion établie, on passe ensuite à l'échange TLS (Client Hello, Server Hello, etc.).



Utilisation des filtres Wireshark

Quelques exemples de filtres utiles :

arp : n'affiche que les trames ARP

udp : paquets UDP

tcp.port == 443 : connexions HTTPS

ip.addr == 10.10.0.1 : trafic associé à une IP

Les filtres permettent de cibler des trames précises et de s'y retrouver dans un trafic massif.

Analyse de protocoles locaux (Partie 2)

DHCP (Dynamic Host Configuration Protocol)

IP source : 0.0.0.0

IP destination : 255.255.255.255

MAC source : xx:xx:xx:xx:xx:xx

Ports : 68 (client) → 67 (serveur)

Étapes : Discover, Offer, Request, ACK

Couche 4 : UDP

DNS (Domain Name System)

Requête A google.com

Réponse IP : 172.217.19.142

Ports : client → 53

Couche 4 : UDP

mDNS (Multicast DNS)

Adresse : 224.0.0.251, Port : 5353

Requêtes PTR pour .local

Permet de découvrir les équipements sur le réseau local

TLS / HTTPS

Port destination : 443

Phases : Client Hello, Server Hello, Application Data

Couche 4 : TCP, Couche 6 : TLS

Capture en ligne de commande avec Tshark

Installation

sudo apt install tshark
sudo dpkg-reconfigure wireshark-common
sudo usermod -aG wireshark $USER

(Reconnexion nécessaire)

Commandes de base

Lister les interfaces : tshark -D

Capture simple : sudo tshark -i wlp2s0

Exemples de filtres :

sudo tshark -i wlp2s0 -f "udp port 53" -c 20 -w dns.pcapng
sudo tshark -i wlp2s0 -f "port 67 or port 68" -c 20 -w dhcp.pcapng
sudo tshark -i wlp2s0 -f "tcp port 443" -c 20 -w tls.pcapng
sudo tshark -i wlp2s0 -f "udp port 5353" -c 20 -w mdns.pcapng

Script automatisé : capture_multi_proto.sh

------------------------------------------------------------------------------
#!/bin/bash

INTERFACE="wlp2s0"

OUTDIR="captures_tshark"

mkdir -p "$OUTDIR"

echo "[+] Début des captures..."

tshark -i "$INTERFACE" -f "udp port 53" -c 50 -w "$OUTDIR/dns.pcapng"

tshark -i "$INTERFACE" -f "port 67 or port 68" -c 30 -w "$OUTDIR/dhcp.pcapng"

tshark -i "$INTERFACE" -f "tcp port 443" -c 30 -w "$OUTDIR/tls.pcapng"

tshark -i "$INTERFACE" -f "udp port 5353" -c 30 -w "$OUTDIR/mdns.pcapng"

tshark -i "$INTERFACE" -f "tcp port 21" -c 30 -w "$OUTDIR/ftp.pcapng"

tshark -i "$INTERFACE" -f "tcp port 445" -c 30 -w "$OUTDIR/smb.pcapng"

echo "[+] Captures terminées. Fichiers disponibles dans : $OUTDIR/"

------------------------------------------------------------------------------

Ce script permet de capturer automatiquement les principaux protocoles réseaux locaux de manière fiable.

Projet réalisé dans le cadre de l'apprentissage du modèle OSI, des protocoles réseau, et de l'analyse de trafic pour la cybersécurité.
