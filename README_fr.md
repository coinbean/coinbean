<div align="center">
  <img src="images/banner.png" alt="Bannière Coinbean" width="100%">
</div>

<div align="center">

Un système complet de suivi de portefeuille de cryptomonnaies basé sur [Beancount](https://github.com/beancount/beancount), le système de comptabilité en partie double.

**Créé par [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)**

[English](README.md) | [简体中文](README_zh.md) | Français | [한국어](README_ko.md) | [日本語](README_ja.md) | [Español](README_es.md)

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/coinbean_org](https://x.com/coinbean_org)

</div>

## 🎥 Vidéo de démonstration

[![Démonstration Coinbean](https://img.youtube.com/vi/2TaJvP5Ysfc/maxresdefault.jpg)](https://youtu.be/2TaJvP5Ysfc)

## ⚡ Démarrage rapide

### Option 1: Docker (Recommandé)

```bash
./run.sh  # Sélectionnez l'option 1 pour Docker
# Ou: docker-compose up -d
```

### Option 2: Installation native

```bash
./setup.sh              # Installer les dépendances
./run.sh                # Démarrer l'interface web Fava
./prices.sh             # Récupérer les prix actuels
```

Ouvrez http://localhost:5002 pour voir votre portefeuille.

## Qu'est-ce que Coinbean ?

Coinbean est un modèle de registre Beancount structuré pour suivre les portefeuilles de cryptomonnaies à travers :

- Plusieurs plateformes d'échange centralisées (Coinbase, Binance, Kraken, etc.)
- Portefeuilles matériels et logiciels (Ledger, Trezor, MetaMask, Phantom)
- Protocoles DeFi (Aave, Compound, Uniswap, Raydium, Jupiter, etc.)
- DEX perpétuels (Hyperliquid, dYdX, GMX)
- Protocoles de staking liquide (Lido, Rocket Pool, Jito, Marinade)
- Protocoles de restaking (EigenLayer, Solayer)
- Collections NFT (BAYC, Azuki, DeGods, Bitcoin Ordinals, et plus)
- Activités de staking et de yield farming
- Plus de 110 cryptomonnaies à travers Layer-1, Layer-2, DeFi, stablecoins, NFTs, et plus

## Fonctionnalités

- **Couverture complète des actifs** : Support préconfiguré pour plus de 110 cryptomonnaies et collections NFT incluant BTC, ETH, SOL, et bien d'autres
- **Support multi-plateformes** : Suivez vos actifs sur plus de 10 plateformes d'échange majeures (Coinbase, Binance, Kraken, Gemini, Crypto.com, etc.)
- **Intégration DeFi** : Comptabilisation des prêts, pools de liquidité et staking
- **Suivi des NFT** : Support pour les collections NFT populaires sur Ethereum, Solana, Bitcoin Ordinals, Polygon et Base
- **Bitcoin Ordinals & BRC-20** : Suivez les inscriptions Ordinals et tokens BRC-20 (ORDI, SATS, etc.)
- **Gestion précise des décimales** : Tolérances configurées pour les satoshis, gwei et autres petites unités
- **Comptabilité en partie double** : Piste d'audit complète avec principes comptables appropriés
- **Prêt pour les déclarations fiscales** : Suivez les plus-values, frais et revenus de diverses sources
- **Interface web** : Belle visualisation avec Fava
- **Installation facile** : Scripts d'installation et d'exécution automatisés inclus

## ⚡ Référence rapide

| Script           | Commande      | Objectif                                     |
| ---------------- | ------------- | -------------------------------------------- |
| **Installation** | `./setup.sh`  | Installer Beancount & Fava, valider le registre |
| **Lancer Fava**  | `./run.sh`    | Démarrer l'interface web sur http://localhost:5002 |
| **Récupérer prix** | `./prices.sh` | Obtenir les prix actuels des cryptos (menu interactif) |

Voir la section [Scripts utilitaires](#scripts-utilitaires) pour la documentation détaillée.

## Structure des fichiers

Coinbean utilise une **structure modulaire** pour une meilleure organisation :

```
crypto/
├── crypto_main.beancount       # Registre principal avec commodités et imports
├── exchanges.beancount         # Comptes des plateformes d'échange centralisées
├── chains.beancount            # Portefeuilles blockchain & staking natif
├── defi.beancount              # Protocoles DeFi, staking liquide, restaking
├── crypto_prices.beancount     # Données de prix pour tous les actifs
├── tx_2024.beancount           # Transactions 2024
├── tx_2025.beancount           # Transactions 2025
├── crypto_examples.beancount   # Plus de 20 exemples de transactions (référence)
├── fetch_prices.py             # Récupération automatique des prix depuis CoinGecko
├── prices.sh                   # Wrapper pratique pour fetch_prices.py
├── setup.sh                    # Script d'installation et de configuration automatisé
├── run.sh                      # Démarrer l'interface web Fava
└── README.md                   # Ce fichier
```

## Structure des comptes

Coinbean suit les principes de **comptabilité en partie double** de Beancount avec une structure de compte hiérarchique :

```
Assets:Crypto
├── Exchange                    # Plateformes d'échange centralisées
│   ├── Coinbase
│   │   ├── Cash:USD           # Soldes fiat
│   │   ├── BTC                # Solde Bitcoin
│   │   ├── ETH                # Solde Ethereum
│   │   └── Other              # Autres tokens
│   ├── Binance
│   ├── Kraken
│   └── [Plus de 10 plateformes...]
│
├── Wallet                      # Portefeuilles auto-gardés
│   ├── Ledger                 # Portefeuilles matériels
│   │   ├── BTC
│   │   └── ETH
│   ├── MetaMask               # Portefeuilles logiciels
│   ├── Phantom
│   └── [Plus de portefeuilles...]
│
├── Staking                     # Staking natif de blockchain
│   ├── ETH
│   │   ├── Delegated          # Montant staké
│   │   └── Rewards            # Récompenses gagnées
│   ├── SOL
│   ├── ADA
│   └── [Plus de chaînes...]
│
├── DeFi                        # Protocoles DeFi
│   ├── Aave                   # Prêts
│   │   ├── USDC
│   │   └── ETH
│   ├── Uniswap                # DEXs
│   │   └── LPTokens
│   ├── Hyperliquid            # DEX perpétuels
│   ├── Lido                   # Staking liquide
│   │   └── STETH
│   └── [Plus de protocoles...]
│
└── NFT                         # Collections NFT
    ├── Ethereum
    │   ├── BAYC
    │   ├── Azuki
    │   └── [Plus de collections...]
    ├── Solana
    │   ├── DeGods
    │   └── MadLads
    └── Bitcoin
        └── NodeMonkes

Liabilities:Crypto
└── DeFi                        # Prêts DeFi
    ├── Aave:Borrowed
    └── Compound:Borrowed

Income:Crypto
├── Staking:Rewards             # Revenus de staking
├── Mining:Rewards              # Revenus de mining
├── Airdrops                    # Tokens airdrop
├── Referrals                   # Bonus de parrainage
└── Trading:CapitalGains        # Gains réalisés

Expenses:Crypto
├── Trading:Fees                # Frais d'échange
├── Withdrawal:Fees             # Frais de retrait
├── Gas                         # Frais de transaction
│   ├── Ethereum
│   ├── Solana
│   └── [Autres chaînes...]
└── Trading:Losses              # Pertes réalisées

Equity:Opening-Balances         # Soldes initiaux
```

### Convention de nommage des comptes

Coinbean utilise une structure de nommage hiérarchique cohérente :

```
Assets:Crypto:{Type}:{Plateforme}:{Actif}
             └──┬──┘ └────┬────┘ └──┬──┘
              Type     Plateforme   Token
                                   spécifique
```

**Exemples :**

- `Assets:Crypto:Exchange:Coinbase:BTC` - Bitcoin sur Coinbase
- `Assets:Crypto:Wallet:Ledger:ETH` - Ethereum sur Ledger
- `Assets:Crypto:DeFi:Aave:USDC` - USDC déposé dans Aave
- `Assets:Crypto:Staking:SOL:Delegated` - Solana staké
- `Assets:Crypto:NFT:Ethereum:BAYC` - NFT Bored Ape Yacht Club

**Conseils :**

- Utilisez CamelCase pour les noms de plateformes (ex: `MetaMask`, pas `metamask`)
- Gardez les tickers d'actifs en MAJUSCULES (ex: `BTC`, `ETH`)
- Soyez cohérent dans toutes vos transactions

## Exemples de transactions

### Acheter des cryptos sur une plateforme d'échange

```beancount
2025-01-15 * "Coinbase" "Acheter Bitcoin"
  Assets:Crypto:Exchange:Coinbase:BTC     0.5 BTC {50000.00 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD  -25000.00 USD
  Expenses:Crypto:Trading:Fees                   50.00 USD
```

### Transférer vers un stockage froid

```beancount
2025-01-16 * "Transfert vers Ledger" "Déplacer BTC vers portefeuille matériel"
  Assets:Crypto:Wallet:Ledger:BTC            0.5 BTC
  Assets:Crypto:Exchange:Coinbase:BTC       -0.5 BTC
  Expenses:Crypto:Withdrawal:Fees          0.0001 BTC
```

### Récompenses de staking

```beancount
2025-01-20 * "Récompenses de staking" "Récompenses de staking ETH"
  Assets:Crypto:Staking:ETH              0.05 ETH
  Income:Crypto:Staking:Rewards         -0.05 ETH {2500.00 USD}
```

### Prêt DeFi

```beancount
2025-01-25 * "Aave" "Dépôt USDC pour prêt"
  Assets:Crypto:DeFi:Aave:USDC              5000 USDC
  Assets:Crypto:Wallet:MetaMask:USDC       -5000 USDC
  Expenses:Crypto:Gas:Ethereum                 15.00 USD
```

## Actifs supportés

### Blockchains Layer-1

BTC, ETH, SOL, ADA, DOT, AVAX, ATOM, ALGO, XRP, XLM, NEAR, FTM, TON, APT, SUI, LTC, BCH, ETC, et plus

### Solutions Layer-2

MATIC, OP, ARB

### Stablecoins

USDT, USDC, DAI, BUSD, TUSD

### Tokens DeFi

UNI, AAVE, MKR, COMP, SNX, CRV, SUSHI

### Tokens d'échange

BNB, CRO, FTT

### DEX perpétuels

HYPE (Hyperliquid), DYDX (dYdX), GMX

### DEX Solana

RAY (Raydium), JUP (Jupiter), ORCA (Orca)

### Staking liquide & Restaking

- **Ethereum** : LDO (Lido), STETH, RPL (Rocket Pool), RETH, EIGEN (EigenLayer)
- **Solana** : JTO (Jito), JITOSOL, MNDE (Marinade), MSOL

### Tokens de l'écosystème NFT

APE (ApeCoin), LOOKS (LooksRare), X2Y2, SUDO (Sudoswap), BLUR (Blur), NFT (APENFT)

### Bitcoin Ordinals & BRC-20

ORDI (Ordinals), SATS, RATS, PUPS (Bitcoin Puppets), TRAC

### Collections NFT supportées

- **Ethereum** : BAYC, MAYC, Azuki, CloneX, Doodles, Pudgy Penguins, Moonbirds, Cryptopunks, Meebits, Art Blocks, PROOF Collective
- **Solana** : DeGods, y00ts, Mad Lads, Solana Monkey Business, Okay Bears, Tensorians
- **Bitcoin Ordinals** : NodeMonkes, Bitcoin Puppets, Quantum Cats, Ordinal Inscriptions
- **Polygon** : Reddit Collectible Avatars
- **Base** : Based Fellas

## Ressources

Visitez [coinbean.org/docs](http://coinbean.org/docs) pour en savoir plus sur :

- Modèles de transactions avancés
- Stratégies de déclaration fiscale
- Intégration avec d'autres outils
- Meilleures pratiques de la communauté

**Liens du projet :**

- 📦 [Dépôt GitHub](https://github.com/qai-lab/coinbean) - Code source, problèmes et contributions
- 📋 [Notes de version](https://github.com/qai-lab/coinbean/releases) - Historique des versions et changelog
- 🌐 [Site web Coinbean](https://coinbean.org/) - Site officiel et documentation
- 🐦 [Coinbean sur X/Twitter](https://x.com/coinbean_org) - Suivez pour les mises à jour et actualités
- 📚 [Documentation Beancount](https://beancount.github.io/docs/) - Apprenez Beancount
- 🖥️ [Fava - Interface web](https://github.com/beancount/fava) - Interface web Beancount
- 💬 [Plain Text Accounting](https://plaintextaccounting.org/) - Communauté et ressources

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à soumettre une Pull Request. Domaines de contribution :

- Modèles de plateformes d'échange supplémentaires
- Plus de protocoles DeFi
- Scripts d'automatisation pour importer les transactions
- Améliorations de la documentation

## Auteur

**Coinbean** est créé et maintenu par :

- **Boyuan Qian**
  - 🐙 GitHub: [@boyuanqian](https://github.com/boyuanqian)
  - 🐦 X/Twitter: [@boyuan_qian](https://x.com/boyuan_qian)
  - 🏢 Organisation: [QAI Lab](https://github.com/qai-lab)

**QAI Lab**

- 🌐 Site web: [qai.io](https://qai.io)
- 🐙 GitHub: [@qai-lab](https://github.com/qai-lab)
- 🐦 X/Twitter: [@qai_lab](https://x.com/qai_lab)

## Licence

Licence MIT - Copyright (c) 2025 Boyuan Qian et QAI Lab

Voir le fichier [LICENSE](LICENSE) pour les détails.

Ce modèle est fourni tel quel pour usage personnel. Personnalisez selon vos besoins de suivi de portefeuille.

## Avertissement

Ceci est un outil de suivi financier personnel. Il ne fournit pas :

- Conseils financiers
- Conseils fiscaux
- Recommandations d'investissement

Consultez toujours des professionnels qualifiés pour les questions financières et fiscales. Les investissements en cryptomonnaies sont risqués et peuvent entraîner une perte de capital.

---

**Bon suivi ! 📊💰**
