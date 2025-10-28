<div align="center">
  <img src="images/banner.png" alt="Bannière Coinbean" width="100%">
</div>

<div align="center">

Coinbean AI - un système complet de suivi de portefeuille de cryptomonnaies, le système de comptabilité en partie double.

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/CoinbeanAI](https://x.com/CoinbeanAI)

[English](README.md) | [简体中文](README_zh.md) | Français | [한국어](README_ko.md) | [日本語](README_ja.md) | [Español](README_es.md)

---

**Créé par [Boyuan Qian](https://github.com/boyuanqian) @[QAI Lab](https://github.com/qai-lab)**

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

Suivez votre portefeuille crypto sur les plateformes d'échange, portefeuilles, DeFi, staking et NFT avec la comptabilité en partie double.

**Supporte:**

- 10+ plateformes d'échange (Coinbase, Binance, Kraken, etc.)
- Portefeuilles matériels/logiciels (Ledger, MetaMask, Phantom)
- Protocoles DeFi (Aave, Uniswap, Lido, Hyperliquid)
- Staking & yield farming
- NFT (Ethereum, Solana, Bitcoin Ordinals)
- 110+ cryptomonnaies

## Fonctionnalités

- ✅ Comptes pré-configurés pour les plateformes d'échange, portefeuilles et DeFi
- ✅ Support de 110+ cryptomonnaies avec récupération automatique des prix
- ✅ Suivi des NFT et Bitcoin Ordinals
- ✅ Déclaration fiscale avec suivi des plus-values
- ✅ Belle interface web (Fava)
- ✅ Support Docker pour un déploiement facile

## Structure des fichiers

```
coinbean/
├── crypto_main.beancount       # Registre principal (110+ cryptos définies)
├── exchanges.beancount         # Comptes des plateformes d'échange
├── chains.beancount            # Portefeuilles & staking
├── defi.beancount              # Protocoles DeFi
├── crypto_prices.beancount     # Données de prix
├── tx_2025.beancount           # Vos transactions
├── crypto_examples.beancount   # 20+ exemples de transactions
├── setup.sh / run.sh / prices.sh
└── docker-compose.yml
```

**Éditez ces fichiers:**

- `tx_2025.beancount` - Ajoutez vos transactions
- `exchanges.beancount` - Activez uniquement les plateformes que vous utilisez
- `chains.beancount` - Ajoutez vos portefeuilles
- `defi.beancount` - Ajoutez les protocoles DeFi que vous utilisez

## Structure des comptes

```
Assets:Crypto
├── Exchange:{Plateforme}:{Actif}     # Coinbase:BTC, Binance:ETH
├── Wallet:{Portefeuille}:{Actif}     # Ledger:BTC, MetaMask:ETH
├── Staking:{Chaîne}:{Statut}         # ETH:Delegated, SOL:Rewards
├── DeFi:{Protocole}:{Actif}          # Aave:USDC, Uniswap:LPTokens
└── NFT:{Chaîne}:{Collection}         # Ethereum:BAYC, Solana:DeGods

Income:Crypto
├── Staking:Rewards
├── Trading:CapitalGains
└── Airdrops

Expenses:Crypto
├── Trading:Fees
├── Gas:{Chaîne}                      # Ethereum, Solana, etc.
└── Withdrawal:Fees
```

## Enregistrer des transactions

Consultez `crypto_examples.beancount` pour 20+ exemples. Format de base:

```beancount
2025-01-15 * "Coinbase" "Acheter Bitcoin"
  Assets:Crypto:Exchange:Coinbase:BTC      0.1 BTC {60000 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD -6000.00 USD
  Expenses:Crypto:Trading:Fees             10.00 USD
```

## Personnalisation

### Ajouter une nouvelle plateforme d'échange

Éditez `exchanges.beancount`:

```beancount
2020-01-01 open Assets:Crypto:Exchange:VotrePlateforme:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:VotrePlateforme:BTC
2020-01-01 open Assets:Crypto:Exchange:VotrePlateforme:ETH
```

### Ajouter une nouvelle cryptomonnaie

Éditez `crypto_main.beancount`:

```beancount
2020-01-01 commodity VOTRE
  name: "Votre Monnaie"
  blockchain: "Ethereum"
  category: "DeFi"
```

Puis ajoutez à `fetch_prices.py`:

```python
Asset('VOTRE', 'Your Coin', 'Ethereum', 'DeFi', 'your-coin-id'),
```

### Désactiver les modules non utilisés

Commentez dans `crypto_main.beancount`:

```beancount
include "exchanges.beancount"
include "chains.beancount"
; include "defi.beancount"  # N'utilise pas DeFi
```

## Commandes

| Commande                                       | Objectif                               |
| ---------------------------------------------- | -------------------------------------- |
| `./run.sh`                                     | Démarrer Fava (menu interactif)        |
| `./prices.sh`                                  | Récupérer les prix actuels des cryptos |
| `bean-check crypto_main.beancount`             | Valider le registre                    |
| `bean-query crypto_main.beancount "SELECT..."` | Interroger les données                 |
| `docker-compose up -d`                         | Démarrer avec Docker                   |
| `docker-compose logs -f`                       | Voir les logs Docker                   |

## Déclaration fiscale

**Événements imposables suivis automatiquement:**

- Plus-values/moins-values (ventes de crypto, swaps)
- Récompenses de staking (en tant que revenu)
- Airdrops (en tant que revenu)
- Rendement DeFi (en tant que revenu)

**Générer des rapports:**

```bash
# Voir toutes les plus-values
bean-query crypto_main.beancount "
  SELECT date, account, sum(position)
  WHERE account ~ 'CapitalGains'
  ORDER BY date"

# Voir les revenus de staking
bean-query crypto_main.beancount "
  SELECT date, sum(position)
  WHERE account ~ 'Staking:Rewards'"
```

## Sécurité

⚠️ **Important:** Ne commitez jamais de données financières non chiffrées dans des dépôts publics.

**Utilisez git-crypt pour chiffrer les fichiers sensibles:**

```bash
brew install git-crypt
git-crypt init
echo "*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
echo "tx_*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
```

## Dépannage

| Problème                    | Solution                                                                      |
| --------------------------- | ----------------------------------------------------------------------------- |
| Erreurs `bean-check`        | Vérifier les noms de comptes, s'assurer que les transactions sont équilibrées |
| Les prix ne s'affichent pas | Exécuter `./prices.sh`, vérifier `crypto_prices.beancount`                    |
| Décalage de solde           | Examiner toutes les transactions, vérifier les frais manquants                |
| Fava ne démarre pas         | Vérifier si le port 5002 est utilisé, essayer `./run.sh -p 5003`              |
| Problèmes Docker            | Vérifier les logs avec `docker-compose logs`                                  |

## Ressources

- 📦 [Dépôt GitHub](https://github.com/coinbean/coinbean)
- 📋 [Notes de version](https://github.com/coinbean/coinbean/releases)
- 🌐 [Site Coinbean](https://coinbean.org/)
- 🐦 [Suivre sur X/Twitter](https://x.com/CoinbeanAI)
- 📚 [Docs Beancount](https://beancount.github.io/docs/)
- 🖥️ [Documentation Fava](https://github.com/beancount/fava)

## Auteur

**Créé par:**

- **Boyuan Qian** - [@boyuanqian](https://github.com/boyuanqian) | [@boyuan_qian](https://x.com/boyuan_qian)

**Organisation:**

- **QAI Lab** - [qai.io](https://qai.io) | [@qai-lab](https://github.com/qai-lab) | [@qai_lab](https://x.com/qai_lab)

## Licence

Licence MIT - Copyright (c) 2025 Boyuan Qian et QAI Lab. Voir le fichier [LICENSE](LICENSE).

## Avertissement

Cet outil est uniquement pour le suivi de portefeuille personnel. Il ne fournit pas de conseils financiers, fiscaux ou d'investissement. Les investissements en cryptomonnaies comportent des risques. Consultez des professionnels qualifiés pour les questions financières et fiscales.

---

**Bon suivi ! 📊**
