# Analyse réseau — Wireshark & Tshark

Capture et analyse de trafic réseau avec Wireshark (interface graphique) et Tshark (ligne de commande). Étude des protocoles courants, identification des couches OSI, filtrage de paquets et automatisation des captures.

---

## Objectifs

- Capturer du trafic réseau en environnement contrôlé
- Analyser les protocoles des couches 2 à 7 du modèle OSI
- Écrire des filtres de capture et d'affichage ciblés
- Automatiser les captures multi-protocoles avec Tshark

## Protocoles analysés

| Outil | Protocoles |
|---|---|
| Wireshark | ARP, UDP, TCP |
| Tshark | DNS, mDNS, DHCP, TLS/SSL, HTTPS, FTP, SMB |

## Structure du repo

```
Wireshark/
├── capture_multi_proto.sh       # Script d'automatisation des captures Tshark
├── documentation/
│   └── analyse_reseau.md        # Analyses détaillées, filtres et captures d'écran
└── README.md
```

## Utilisation

### Prérequis

- `tshark` installé (`sudo apt install tshark`)
- Droits suffisants pour capturer le trafic réseau

### Lancer les captures automatisées

```bash
chmod +x capture_multi_proto.sh
sudo ./capture_multi_proto.sh
```

Le script génère les captures dans un dossier dédié, organisées par protocole.

### Filtres Wireshark utiles

```
# Filtrer le trafic DNS
dns

# Voir uniquement les handshakes TCP
tcp.flags.syn == 1

# Filtrer par IP source
ip.src == 192.168.1.1

# Trafic HTTPS uniquement
tcp.port == 443

# Trames ARP
arp
```

## Concepts abordés

- **Modèle OSI** : identification des couches dans les captures
- **TCP** : handshake 3 voies (SYN / SYN-ACK / ACK), séquence et acquittement
- **DNS** : requêtes/réponses, enregistrements A, AAAA, MX
- **DHCP** : processus DORA (Discover, Offer, Request, Acknowledge)
- **TLS/SSL** : handshake, certificats, chiffrement des flux
- **SMB** : authentification et accès aux partages réseau
- **Lecture hexadécimale** : décodage manuel des trames

## Contexte

Projet réalisé dans le cadre de la formation **Administrateur d'infrastructures sécurisées** à [La Plateforme_ (Cannes)](https://laplateforme.io).

---

*Alexandre Kegresse — [github.com/alexandre-kegresse](https://github.com/alexandre-kegresse)*
