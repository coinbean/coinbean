<div align="center">
  <img src="images/banner.png" alt="Coinbean Banner" width="100%">
</div>

<div align="center">

A comprehensive cryptocurrency portfolio tracking system built on [Beancount](https://github.com/beancount/beancount), the double-entry accounting system.

**Created by [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)**

English | [简体中文](README_zh.md) | [Français](README_fr.md) | [한국어](README_ko.md) | [日本語](README_ja.md) | [Español](README_es.md)

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/CoinbeanAI](https://x.com/CoinbeanAI)

</div>

## 🎥 Demo Video

[![Coinbean Demo](https://img.youtube.com/vi/2TaJvP5Ysfc/maxresdefault.jpg)](https://youtu.be/2TaJvP5Ysfc)

## ⚡ Quick Start

### Option 1: Docker (Recommended)

```bash
./run.sh  # Select option 1 for Docker
# Or: docker-compose up -d
```

### Option 2: Native Installation

```bash
./setup.sh              # Install dependencies
./run.sh                # Start Fava web interface
./prices.sh             # Fetch current prices
```

Open http://localhost:5002 to view your portfolio.

## What is Coinbean?

Track your crypto portfolio across exchanges, wallets, DeFi, staking, and NFTs using double-entry accounting.

**Supports:**

- 10+ exchanges (Coinbase, Binance, Kraken, etc.)
- Hardware/software wallets (Ledger, MetaMask, Phantom)
- DeFi protocols (Aave, Uniswap, Lido, Hyperliquid)
- Staking & yield farming
- NFTs (Ethereum, Solana, Bitcoin Ordinals)
- 110+ cryptocurrencies

## Features

- ✅ Pre-configured accounts for exchanges, wallets, and DeFi
- ✅ 110+ cryptocurrency support with automatic price fetching
- ✅ NFT and Bitcoin Ordinals tracking
- ✅ Tax reporting with capital gains tracking
- ✅ Beautiful web interface (Fava)
- ✅ Docker support for easy deployment

## File Structure

```
coinbean/
├── crypto_main.beancount       # Main ledger (110+ cryptos defined)
├── exchanges.beancount         # Exchange accounts
├── chains.beancount            # Wallets & staking
├── defi.beancount              # DeFi protocols
├── crypto_prices.beancount     # Price data
├── tx_2025.beancount           # Your transactions
├── crypto_examples.beancount   # 20+ example transactions
├── setup.sh / run.sh / prices.sh
└── docker-compose.yml
```

**Edit these files:**

- `tx_2025.beancount` - Add your transactions
- `exchanges.beancount` - Enable only exchanges you use
- `chains.beancount` - Add your wallets
- `defi.beancount` - Add DeFi protocols you use

## Account Structure

```
Assets:Crypto
├── Exchange:{Exchange}:{Asset}     # Coinbase:BTC, Binance:ETH
├── Wallet:{Wallet}:{Asset}         # Ledger:BTC, MetaMask:ETH
├── Staking:{Chain}:{Status}        # ETH:Delegated, SOL:Rewards
├── DeFi:{Protocol}:{Asset}         # Aave:USDC, Uniswap:LPTokens
└── NFT:{Chain}:{Collection}        # Ethereum:BAYC, Solana:DeGods

Income:Crypto
├── Staking:Rewards
├── Trading:CapitalGains
└── Airdrops

Expenses:Crypto
├── Trading:Fees
├── Gas:{Chain}                     # Ethereum, Solana, etc.
└── Withdrawal:Fees
```

## Recording Transactions

See `crypto_examples.beancount` for 20+ examples. Basic format:

```beancount
2025-01-15 * "Coinbase" "Buy Bitcoin"
  Assets:Crypto:Exchange:Coinbase:BTC      0.1 BTC {60000 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD -6000.00 USD
  Expenses:Crypto:Trading:Fees             10.00 USD
```

## Customization

### Add New Exchange

Edit `exchanges.beancount`:

```beancount
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:YourExchange:BTC
2020-01-01 open Assets:Crypto:Exchange:YourExchange:ETH
```

### Add New Cryptocurrency

Edit `crypto_main.beancount`:

```beancount
2020-01-01 commodity YOUR
  name: "Your Coin"
  blockchain: "Ethereum"
  category: "DeFi"
```

Then add to `fetch_prices.py`:

```python
Asset('YOUR', 'Your Coin', 'Ethereum', 'DeFi', 'your-coin-id'),
```

### Disable Unused Modules

Comment out in `crypto_main.beancount`:

```beancount
include "exchanges.beancount"
include "chains.beancount"
; include "defi.beancount"  # Not using DeFi
```

## Commands

| Command                                        | Purpose                       |
| ---------------------------------------------- | ----------------------------- |
| `./run.sh`                                     | Start Fava (interactive menu) |
| `./prices.sh`                                  | Fetch current crypto prices   |
| `bean-check crypto_main.beancount`             | Validate ledger               |
| `bean-query crypto_main.beancount "SELECT..."` | Query data                    |
| `docker-compose up -d`                         | Start with Docker             |
| `docker-compose logs -f`                       | View Docker logs              |

## Tax Reporting

**Taxable events tracked automatically:**

- Capital gains/losses (crypto sales, swaps)
- Staking rewards (as income)
- Airdrops (as income)
- DeFi yield (as income)

**Generate reports:**

```bash
# View all capital gains
bean-query crypto_main.beancount "
  SELECT date, account, sum(position)
  WHERE account ~ 'CapitalGains'
  ORDER BY date"

# View staking income
bean-query crypto_main.beancount "
  SELECT date, sum(position)
  WHERE account ~ 'Staking:Rewards'"
```

## Security

⚠️ **Important:** Never commit unencrypted financial data to public repositories.

**Use git-crypt to encrypt sensitive files:**

```bash
brew install git-crypt
git-crypt init
echo "*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
echo "tx_*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
```

## Troubleshooting

| Issue               | Solution                                             |
| ------------------- | ---------------------------------------------------- |
| `bean-check` errors | Check account names, ensure transactions balance     |
| Prices not showing  | Run `./prices.sh`, check `crypto_prices.beancount`   |
| Balance mismatch    | Review all transactions, check for missing fees      |
| Fava won't start    | Check if port 5002 is in use, try `./run.sh -p 5003` |
| Docker issues       | Check logs with `docker-compose logs`                |

## Resources

- 📦 [GitHub Repository](https://github.com/qai-lab/coinbean)
- 📋 [Release Notes](https://github.com/qai-lab/coinbean/releases)
- 🌐 [Coinbean Website](https://coinbean.org/)
- 🐦 [Follow on X/Twitter](https://x.com/CoinbeanAI)
- 📚 [Beancount Docs](https://beancount.github.io/docs/)
- 🖥️ [Fava Documentation](https://github.com/beancount/fava)

## Author

**Created by:**

- **Boyuan Qian** - [@boyuanqian](https://github.com/boyuanqian) | [@boyuan_qian](https://x.com/boyuan_qian)

**Organization:**

- **QAI Lab** - [qai.io](https://qai.io) | [@qai-lab](https://github.com/qai-lab) | [@qai_lab](https://x.com/qai_lab)

## License

MIT License - Copyright (c) 2025 Boyuan Qian and QAI Lab. See [LICENSE](LICENSE) file.

## Disclaimer

This tool is for personal portfolio tracking only. It does not provide financial, tax, or investment advice. Cryptocurrency investments carry risk. Consult qualified professionals for financial and tax matters.

---

**Happy Tracking! 📊**
