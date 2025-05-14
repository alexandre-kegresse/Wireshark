Projet Wireshark – Analyse réseau

🎯 Objectif

Ce projet vise à analyser des protocoles réseau courants à l’aide de Wireshark (interface graphique) et Tshark (ligne de commande) dans un contexte pédagogique. Il met en pratique :

les couches du modèle OSI,

la capture de trames réseau,

l’analyse des protocoles TCP/IP,

l’usage de filtres et scripts automatisés.

🧪 Protocoles étudiés

ARP, UDP, TCP (Wireshark)

DNS, mDNS, DHCP, TLS/SSL, HTTPS, FTP, SMB (Tshark)

🚀 Lancer les captures Tshark

chmod +x capture_multi_proto.sh
./capture_multi_proto.sh

Les captures seront enregistrées dans le dossier captures_tshark/.

🧠 Ce que j’ai appris

Lire une trame hexadécimale

Identifier les couches du modèle OSI dans une capture

Filtrer et extraire des paquets spécifiques

Sécuriser ses connexions avec TLS

Comprendre le handshake TCP et les communications réseau

📘 Documentation

Voir documentation/analyse_reseau.md pour une explication complète, captures d’écran, filtres Wireshark, et détails protocolaires.

Projet réalisé dans le cadre de ma formation en administration réseau et cybersécurité.


