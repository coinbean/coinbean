# Coinbean v0.1.0 - Initial Release 🎉

## Release Title

**Coinbean v0.1.0 - Comprehensive Cryptocurrency Portfolio Tracking on Beancount**

---

## 📝 Release Notes

We're excited to announce the first official release of **Coinbean** - a comprehensive cryptocurrency portfolio tracking system built on Beancount's double-entry accounting framework!

### 🎯 What is Coinbean?

Coinbean is a structured Beancount ledger template designed for tracking cryptocurrency portfolios across exchanges, wallets, DeFi protocols, NFTs, and more. It brings professional accounting principles to crypto asset management with full audit trails, tax reporting capabilities, and beautiful visualizations.

---

## ✨ Key Features

### 📊 Comprehensive Asset Coverage

- **110+ cryptocurrencies** pre-configured including:
  - Layer-1 blockchains: BTC, ETH, SOL, ADA, DOT, AVAX, ATOM, and more
  - Layer-2 solutions: MATIC, OP, ARB
  - DeFi tokens: UNI, AAVE, MKR, COMP, CRV, SUSHI
  - Stablecoins: USDT, USDC, DAI, BUSD, TUSD
  - Liquid staking: LDO, STETH, RPL, RETH, JTO, JITOSOL
  - NFT ecosystem: APE, LOOKS, BLUR
  - Bitcoin Ordinals & BRC-20: ORDI, SATS, RATS, PUPS
  - Meme coins: DOGE, SHIB, PEPE, BONK, WIF
  - And many more!

### 🏦 Multi-Platform Support

- **10+ major exchanges** with pre-configured account templates:
  - Tier 1: Coinbase, Binance, Kraken, Gemini
  - Tier 2: Crypto.com, KuCoin, Bybit, OKX, HTX, Gate.io
- **Hardware wallets**: Ledger, Trezor
- **Software wallets**: MetaMask, Phantom, Sui Wallet, Trust Wallet, and more

### 🔄 DeFi Integration

- **Lending protocols**: Aave, Compound, MakerDAO
- **DEXs**: Uniswap, SushiSwap, Curve, PancakeSwap, Raydium, Jupiter, Orca
- **Perpetual DEXs**: Hyperliquid, dYdX, GMX
- **Liquid staking**: Lido (ETH), Rocket Pool (ETH), Jito (SOL), Marinade (SOL)
- **Restaking**: EigenLayer, Solayer, Renzo, Ether.fi

### 🖼️ NFT Tracking

- Support for popular NFT collections across multiple chains:
  - **Ethereum**: BAYC, MAYC, Azuki, CloneX, Doodles, Pudgy Penguins, CryptoPunks
  - **Solana**: DeGods, y00ts, Mad Lads, Okay Bears
  - **Bitcoin Ordinals**: NodeMonkes, Bitcoin Puppets, Quantum Cats
  - **Polygon**: Reddit Collectible Avatars
  - **Base**: Based Fellas

### 💰 Automated Price Fetching

- **Interactive price fetcher** (`./prices.sh`) with:
  - Real-time prices from CoinGecko API (no API key required)
  - Support for 110+ cryptocurrencies
  - Formatted table display with chain and category information
  - Case-insensitive filtering
  - Beancount format output for direct use
  - Automation support via cron jobs

### 🧮 Tax Reporting Ready

- Capital gains/loss tracking with cost basis
- Staking rewards and income recording
- Trading fees and gas costs tracking
- Query tools for generating tax reports
- Support for FIFO, LIFO, and specific identification methods

### 🎨 Beautiful Web Interface

- **Fava integration** for interactive visualization
- Real-time portfolio valuation
- Interactive charts and graphs
- Income/expense reports
- Balance sheet and net worth tracking
- Custom query editor

### 🔧 Easy Setup & Automation

- **3 simple scripts** to get started:
  - `./setup.sh` - Automated installation and validation
  - `./run.sh` - Start Fava web interface instantly
  - `./prices.sh` - Interactive price fetching menu
- One-command installation
- Pre-configured for immediate use

### 🏗️ Modular Architecture

- **Clean file organization**:
  - `crypto_main.beancount` - Main ledger with commodity definitions
  - `exchanges.beancount` - Centralized exchange accounts
  - `chains.beancount` - Wallets and native staking
  - `defi.beancount` - DeFi protocols and liquid staking
  - `tx_YYYY.beancount` - Annual transaction files
  - `crypto_prices.beancount` - Price data
  - `crypto_examples.beancount` - 20+ transaction examples
- Easy to customize and extend
- Comment out unused modules to keep ledger focused

### 🔒 Security Features

- **git-crypt configuration** for encrypting sensitive transaction data
- `.gitattributes` template included and ready to use
- Comprehensive security documentation
- Privacy-focused best practices
- Safe to use with version control when encrypted

### 📚 Comprehensive Documentation

- **Bilingual documentation**: Full documentation in both English and Chinese (简体中文)
- **20+ transaction examples** covering:
  - Exchange trading and deposits
  - Wallet transfers and gas fees
  - Staking and rewards
  - DeFi lending and liquidity provision
  - NFT purchases and sales
  - Bitcoin Ordinals and BRC-20 tokens
  - Airdrops and referral bonuses
- **Detailed guides** for:
  - Quick start setup
  - Adding new exchanges and wallets
  - Customizing DeFi protocols
  - Adding new cryptocurrencies
  - Tax reporting strategies
  - Troubleshooting common issues

### 🎯 Precision & Accuracy

- Configured tolerances for satoshis, gwei, and small units
- Support for assets with many decimal places
- Proper handling of crypto-specific rounding
- Double-entry accounting for full audit trails

---

## 🚀 Quick Start

### Prerequisites

- Python 3.7+
- pip (Python package manager)

### Three Simple Steps

**Step 1: Clone and Setup**

```bash
git clone https://github.com/coinbean/coinbean.git
cd coinbean
./setup.sh
```

**Step 2: Start Fava Web Interface**

```bash
./run.sh
```

Opens at http://localhost:5002

**Step 3: Fetch Current Prices**

```bash
./prices.sh
```

Interactive menu to get real-time cryptocurrency prices

---

## 📦 What's Included

### Core Files

- ✅ Main ledger with 110+ cryptocurrency definitions
- ✅ Pre-configured account templates for 10+ exchanges
- ✅ DeFi protocol templates for 20+ platforms
- ✅ Wallet and staking account structures
- ✅ NFT tracking templates

### Helper Scripts

- ✅ `setup.sh` - Automated installation
- ✅ `run.sh` - Fava web interface launcher
- ✅ `prices.sh` - Price fetching wrapper
- ✅ `fetch_prices.py` - CoinGecko API integration

### Documentation

- ✅ `README.md` - Comprehensive English documentation
- ✅ `README_zh.md` - Complete Chinese documentation (简体中文)
- ✅ `crypto_examples.beancount` - 20+ transaction examples
- ✅ `.gitattributes` - git-crypt configuration template

### Example Files

- ✅ Sample transaction files by year
- ✅ Example price data
- ✅ Transaction templates for all common operations

---

## 🎓 Example Use Cases

### For Individual Investors

- Track holdings across multiple exchanges and wallets
- Monitor DeFi positions and yields
- Calculate capital gains for tax reporting
- Analyze portfolio performance over time

### For Active Traders

- Record all trades with precise cost basis
- Track trading fees and profitability
- Generate reports for tax filing
- Maintain complete audit trail

### For DeFi Users

- Track lending and borrowing positions
- Monitor liquidity pool performance
- Record staking rewards and airdrops
- Calculate impermanent loss

### For NFT Collectors

- Track NFT acquisitions and sales
- Record marketplace fees
- Calculate capital gains on NFT trades
- Monitor collection values

---

## 🔐 Security & Privacy

### Built-in Protection

- **git-crypt support**: Encrypt sensitive transaction data before committing
- **Privacy-first design**: Template files safe to share publicly
- **Separation of concerns**: Real data kept separate from examples
- **Detailed security documentation**: Step-by-step encryption setup guide

### Recommended Practice

1. Use git-crypt to encrypt `.beancount` files with real transactions
2. Keep examples and templates unencrypted for reference
3. Never commit unencrypted financial data to public repositories
4. Use private repositories even with encryption

---

## 🌐 Language Support

This release includes full documentation in:

- 🇺🇸 **English** (README.md)
- 🇨🇳 **简体中文** (README_zh.md)

Both versions include:

- Complete feature documentation
- Setup and installation guides
- Transaction examples
- Customization instructions
- Troubleshooting tips

---

## 🛠️ Technical Details

### Built With

- **Beancount** - Double-entry accounting system
- **Fava** - Web interface for Beancount
- **Python 3.7+** - Scripting and automation
- **CoinGecko API** - Real-time price data (free tier)

### Requirements

- Python 3.7 or higher
- pip for package management
- Git for version control (optional)
- git-crypt for encryption (optional but recommended)

### Compatibility

- ✅ macOS (tested)
- ✅ Linux (Ubuntu, Debian, Fedora, Arch)
- ✅ Windows (via WSL)

---

## 📖 Documentation Resources

### Quick Links

- 📦 [GitHub Repository](https://github.com/coinbean/coinbean)
- 🌐 [Official Website](https://coinbean.org/)
- 🐦 [Follow on X/Twitter](https://x.com/CoinbeanAI)
- 📚 [Beancount Documentation](https://beancount.github.io/docs/)
- 🖥️ [Fava Documentation](https://beancount.github.io/fava/)

### Learning Resources

- **README.md**: Complete English documentation
- **README_zh.md**: 完整中文文档
- **crypto_examples.beancount**: 20+ annotated transaction examples
- **Helper Scripts**: Automated setup and price fetching guides

---

## 👥 Community & Support

### Connect With Us

- **Coinbean**

  - 🌐 Website: [coinbean.org](https://coinbean.org/)
  - 🐦 X/Twitter: [@CoinbeanAI](https://x.com/CoinbeanAI)
  - 📦 GitHub: [coinbean/coinbean](https://github.com/coinbean/coinbean)

- **Boyuan Qian** (Creator)

  - 🐙 GitHub: [@boyuanqian](https://github.com/boyuanqian)
  - 🐦 X/Twitter: [@boyuan_qian](https://x.com/boyuan_qian)

- **QAI Lab**
  - 🐙 GitHub: [@qai-lab](https://github.com/qai-lab)
  - 🐦 X/Twitter: [@qai_lab](https://x.com/qai_lab)

### Get Help

- Report issues on [GitHub Issues](https://github.com/coinbean/coinbean/issues)
- Ask questions in [Discussions](https://github.com/coinbean/coinbean/discussions)
- Follow for updates on [X/Twitter](https://x.com/CoinbeanAI)

---

## 🤝 Contributing

We welcome contributions! Areas for improvement:

- Additional exchange templates
- More DeFi protocol integrations
- Transaction import automation scripts
- Documentation translations
- Bug fixes and improvements

See our [Contributing Guidelines](https://github.com/coinbean/coinbean#contributing) for more information.

---

## 🔮 What's Next?

This is our initial release (v0.1.0). We're planning to add:

- 🔄 More exchange integrations
- 📊 Enhanced reporting features
- 🤖 Automated transaction import from CSV
- 🌍 Additional language support
- 📱 Mobile-friendly visualizations

Your feedback is invaluable! Please share your thoughts and suggestions.

---

## 📄 License

MIT License - Copyright (c) 2025 Boyuan Qian and QAI Lab

This template is provided as-is for personal use. Customize as needed for your portfolio tracking requirements.

---

## ⚠️ Disclaimer

Coinbean is a personal finance tracking tool. It does **not** provide:

- Financial advice
- Tax advice
- Investment recommendations

Always consult with qualified professionals for financial and tax matters. Cryptocurrency investments are risky and may result in loss of capital.

---

## 🎉 Thank You!

Thank you for trying Coinbean! This is our first release, and we're excited to hear your feedback and improve the tool together.

If you find Coinbean useful, please:

- ⭐ Star the repository on GitHub
- 🐦 Follow us on X/Twitter for updates
- 📢 Share with others who might benefit
- 🤝 Contribute improvements and suggestions
- 💬 Share your feedback and feature requests

**Happy tracking! 📊💰**

---

_Built with ❤️ by [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)_
