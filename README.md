<div align="center">
  <img src="images/banner.png" alt="Coinbean Banner" width="100%">
</div>

<div align="center">

A comprehensive cryptocurrency portfolio tracking system built on [Beancount](https://github.com/beancount/beancount), the double-entry accounting system.

**Created by [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)**

English | [简体中文](README_zh.md)

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/CoinbeanAI](https://x.com/CoinbeanAI)

</div>

## What is Coinbean?

Coinbean is a structured Beancount ledger template for tracking cryptocurrency portfolios across:

- Multiple centralized exchanges (Coinbase, Binance, Kraken, etc.)
- Hardware and software wallets (Ledger, Trezor, MetaMask, Phantom)
- DeFi protocols (Aave, Compound, Uniswap, Raydium, Jupiter, etc.)
- Perpetual DEXs (Hyperliquid, dYdX, GMX)
- Liquid staking protocols (Lido, Rocket Pool, Jito, Marinade)
- Restaking protocols (EigenLayer, Solayer)
- NFT collections (BAYC, Azuki, DeGods, Bitcoin Ordinals, and more)
- Staking and yield farming activities
- 110+ cryptocurrencies across Layer-1, Layer-2, DeFi, stablecoins, NFTs, and more

## Features

- **Comprehensive Asset Coverage**: Pre-configured support for 110+ cryptocurrencies and NFT collections including BTC, ETH, SOL, and many more
- **Multi-Exchange Support**: Track assets across 10+ major exchanges (Coinbase, Binance, Kraken, Gemini, Crypto.com, etc.)
- **DeFi Integration**: Account for lending, liquidity pools, and staking
- **NFT Tracking**: Support for popular NFT collections across Ethereum, Solana, Bitcoin Ordinals, Polygon, and Base
- **Bitcoin Ordinals & BRC-20**: Track Ordinals inscriptions and BRC-20 tokens (ORDI, SATS, etc.)
- **Precise Decimal Handling**: Configured tolerances for satoshis, gwei, and other small units
- **Double-Entry Accounting**: Full audit trail with proper bookkeeping principles
- **Tax Reporting Ready**: Track capital gains, fees, and income from various sources
- **Web Interface**: Beautiful visualization with Fava
- **Easy Setup**: Automated setup and run scripts included

## ⚡ Quick Reference

| Script           | Command       | Purpose                                      |
| ---------------- | ------------- | -------------------------------------------- |
| **Setup**        | `./setup.sh`  | Install Beancount & Fava, validate ledger    |
| **Run Fava**     | `./run.sh`    | Start web interface at http://localhost:5002 |
| **Fetch Prices** | `./prices.sh` | Get current crypto prices (interactive menu) |

See [Helper Scripts](#helper-scripts) section for detailed documentation.

## Quick Start

### Prerequisites

- Python 3.7+
- pip (Python package manager)

### Three Simple Steps

**Step 1: Setup**

```bash
cd /path/to/coinbean
./setup.sh
```

Installs Beancount, Fava, and validates your ledger files.

**Step 2: Start Fava**

```bash
./run.sh
```

Launches the web interface at http://localhost:5002

**Step 3: Fetch Prices**

```bash
./prices.sh
```

Interactive menu to fetch current cryptocurrency prices.

> 📚 See [Helper Scripts](#helper-scripts) section for detailed documentation of each script.

### Manual Installation (Alternative)

If you prefer manual installation:

```bash
pip install beancount fava

# Verify installation
bean-check crypto_main.beancount

# Start Fava
fava -p 5002 crypto_main.beancount
```

### First Steps

1. **Review the examples**: Open `crypto_examples.beancount` to see 20+ transaction examples
2. **Update prices**: Run `./prices.sh` to fetch current market prices ([see details](#3-pricessh---interactive-price-fetcher))
3. **Add your transactions**: Start recording in `tx_2025.beancount`
4. **Customize accounts**: Modify the modular files (`exchanges.beancount`, `chains.beancount`, `defi.beancount`) to match your setup
5. **Explore Fava**: Open http://localhost:5002 to visualize your portfolio ([see details](#2-runsh---start-fava-web-interface))

## File Structure

Coinbean uses a **modular structure** for better organization:

```
crypto/
├── crypto_main.beancount       # Main ledger with commodities and imports
├── exchanges.beancount         # Centralized exchange accounts (Coinbase, Binance, etc.)
├── chains.beancount            # Blockchain wallets & native staking
├── defi.beancount              # DeFi protocols, liquid staking, restaking
├── crypto_prices.beancount     # Price data for all assets
├── tx_2024.beancount           # 2024 transactions
├── tx_2025.beancount           # 2025 transactions
├── crypto_examples.beancount   # 20+ example transactions (reference)
├── fetch_prices.py             # Automated price fetching from CoinGecko
├── prices.sh                   # Convenient wrapper for fetch_prices.py
├── setup.sh                    # Automated setup and installation script
├── run.sh                      # Start Fava web interface
└── README.md                   # This file
```

## Account Structure

Coinbean follows Beancount's **double-entry accounting** principles with a hierarchical account structure:

```
Assets:Crypto
├── Exchange                    # Centralized exchanges
│   ├── Coinbase
│   │   ├── Cash:USD           # Fiat balances
│   │   ├── BTC                # Bitcoin balance
│   │   ├── ETH                # Ethereum balance
│   │   └── Other              # Other tokens
│   ├── Binance
│   ├── Kraken
│   └── [10+ exchanges...]
│
├── Wallet                      # Self-custody wallets
│   ├── Ledger                 # Hardware wallets
│   │   ├── BTC
│   │   └── ETH
│   ├── MetaMask               # Software wallets
│   ├── Phantom
│   └── [More wallets...]
│
├── Staking                     # Native blockchain staking
│   ├── ETH
│   │   ├── Delegated          # Staked amount
│   │   └── Rewards            # Earned rewards
│   ├── SOL
│   ├── ADA
│   └── [More chains...]
│
├── DeFi                        # DeFi protocols
│   ├── Aave                   # Lending
│   │   ├── USDC
│   │   └── ETH
│   ├── Uniswap                # DEXs
│   │   └── LPTokens
│   ├── Hyperliquid            # Perpetual DEXs
│   ├── Lido                   # Liquid staking
│   │   └── STETH
│   └── [More protocols...]
│
└── NFT                         # NFT collections
    ├── Ethereum
    │   ├── BAYC
    │   ├── Azuki
    │   └── [More collections...]
    ├── Solana
    │   ├── DeGods
    │   └── MadLads
    └── Bitcoin
        └── NodeMonkes

Liabilities:Crypto
└── DeFi                        # DeFi loans
    ├── Aave:Borrowed
    └── Compound:Borrowed

Income:Crypto
├── Staking:Rewards             # Staking income
├── Mining:Rewards              # Mining income
├── Airdrops                    # Airdrop tokens
├── Referrals                   # Referral bonuses
└── Trading:CapitalGains        # Realized gains

Expenses:Crypto
├── Trading:Fees                # Exchange fees
├── Withdrawal:Fees             # Withdrawal fees
├── Gas                         # Transaction fees
│   ├── Ethereum
│   ├── Solana
│   └── [Other chains...]
└── Trading:Losses              # Realized losses

Equity:Opening-Balances         # Initial balances
```

### Account Naming Convention

Coinbean uses a consistent hierarchical naming structure:

```
Assets:Crypto:{Type}:{Platform}:{Asset}
             └──┬──┘ └────┬────┘ └──┬──┘
              Type     Platform   Specific
                                   token
```

**Examples:**

- `Assets:Crypto:Exchange:Coinbase:BTC` - Bitcoin on Coinbase
- `Assets:Crypto:Wallet:Ledger:ETH` - Ethereum on Ledger
- `Assets:Crypto:DeFi:Aave:USDC` - USDC deposited in Aave
- `Assets:Crypto:Staking:SOL:Delegated` - Staked Solana
- `Assets:Crypto:NFT:Ethereum:BAYC` - Bored Ape Yacht Club NFT

**Tips:**

- Use CamelCase for platform names (e.g., `MetaMask`, not `metamask`)
- Keep asset tickers in UPPERCASE (e.g., `BTC`, `ETH`)
- Be consistent across all your transactions

### Modular Organization Explained

**🎯 crypto_main.beancount** - The Heart of Your Ledger

This is the main entry point that ties everything together. It contains:

- **110+ cryptocurrency commodity definitions** (BTC, ETH, SOL, NFT tokens, BRC-20, etc.)
- **Income/Expense/Equity accounts** (capital gains, staking rewards, gas fees, etc.)
- **Module imports** via `include` statements
- **Core configuration** (tolerances, operating currency, plugins)

**When to edit:** Adding new cryptocurrencies, changing tolerances, enabling/disabling modules

**💱 exchanges.beancount** - Centralized Exchange Accounts

Pre-configured accounts for 10+ major exchanges:

- **Tier 1**: Coinbase, Binance, Kraken, Gemini
- **Tier 2**: Crypto.com, KuCoin, Bybit, OKX, HTX, Gate.io

Each exchange has:

- Fiat accounts (USD, EUR)
- Major crypto accounts (BTC, ETH, SOL, stablecoins)
- Generic "Other" account for alt-coins

**When to edit:** Adding new exchanges you use, removing exchanges you don't use

**⛓️ chains.beancount** - Self-Custody & Native Staking

Contains accounts for:

- **Hardware Wallets**: Ledger, Trezor
- **Software Wallets**: MetaMask, Phantom, Sui Wallet, Trust Wallet, etc.
- **Native Staking**: Direct staking on ETH, SOL, ADA, DOT, ATOM, SUI, AVAX
- **NFT Collections**: Ethereum, Solana, Bitcoin Ordinals, Polygon, Base

**When to edit:** Adding new wallets, tracking new NFT collections, setting up native staking

**🏦 defi.beancount** - DeFi Protocols & Liquid Staking

Comprehensive DeFi coverage:

- **Lending**: Aave, Compound, MakerDAO
- **DEXs**: Uniswap, SushiSwap, Curve, PancakeSwap, Raydium, Jupiter, Orca
- **Perpetual DEXs**: Hyperliquid, dYdX, GMX
- **Liquid Staking**: Lido (ETH), Rocket Pool (ETH), Jito (SOL), Marinade (SOL)
- **Restaking**: EigenLayer, Solayer, Renzo, Ether.fi

**When to edit:** Adding new DeFi protocols you use, tracking liquidity positions

**💰 tx_2024.beancount & tx_2025.beancount** - Transaction History

Your actual transaction records, separated by year for easier management.

**When to edit:** Daily/weekly as you record your crypto transactions

**📊 crypto_prices.beancount** - Price Data

Historical price data for accurate portfolio valuation.

**When to edit:**

- Automatically via `./prices.sh --beancount >> crypto_prices.beancount`
- Manually for historical prices or assets not on CoinGecko

**📚 crypto_examples.beancount** - Learning Resource

20+ example transactions showing best practices for:

- Exchange trades, wallet transfers, staking, DeFi operations, NFT trades, and more

**When to use:** Reference when you're unsure how to record a transaction type

---

**💡 Customization Tip:** You can comment out entire modules in `crypto_main.beancount` to keep your ledger focused:

```beancount
;; Only include modules you actually use
include "exchanges.beancount"    ; ✓ Using exchanges
include "chains.beancount"       ; ✓ Using wallets
; include "defi.beancount"       ; ✗ Not using DeFi (commented out)
```

## Helper Scripts

Coinbean includes three powerful helper scripts to make managing your crypto portfolio easier.

### 1. `setup.sh` - Automated Installation & Setup

The setup script handles all installation and configuration automatically.

**What it does:**

- Checks for Python 3 installation
- Installs Beancount and Fava packages
- Validates your ledger file syntax
- Optionally installs price fetching dependencies (requests library)
- Verifies everything is working correctly

**Usage:**

```bash
./setup.sh
```

**First-time setup:**

```bash
cd /path/to/coinbean
./setup.sh
```

The script will guide you through the installation process with clear prompts and error messages.

**What to expect:**

1. Python version check
2. Package installation (may require sudo/admin privileges)
3. Ledger validation with `bean-check`
4. Success message with next steps

### 2. `run.sh` - Start Fava Web Interface

The run script launches the Fava web interface for visualizing your portfolio.

**What it does:**

- Checks if Fava is installed
- Validates your ledger file before starting
- Launches Fava on port 5002
- Opens your default browser automatically (optional)

**Usage:**

```bash
./run.sh
```

**Then open your browser to:**

```
http://localhost:5002
```

**Stopping the server:**
Press `Ctrl+C` in the terminal where run.sh is running.

**Custom port:**
Edit `run.sh` and change the port number in the script:

```bash
fava -p 5002 crypto_main.beancount  # Change 5002 to your preferred port
```

**Fava features:**

- Beautiful dashboard with account balances
- Interactive charts and graphs
- Income/expense reports
- Balance sheet and net worth tracking
- Query editor for custom reports

### 3. `prices.sh` - Interactive Price Fetcher

The price fetching script gets current cryptocurrency prices from CoinGecko API.

**What it does:**

- Fetches real-time prices for 110+ cryptocurrencies
- Displays prices in a formatted table with chain info
- Supports filtering by specific tickers
- Can output in Beancount format for direct use
- No API key required (uses CoinGecko free tier)

**Interactive mode** (recommended):

```bash
./prices.sh
```

You'll see a menu:

```
Select an option:
1. Show all cryptocurrency prices
2. Show specific tickers
3. List all supported assets
4. Exit
```

**Command-line mode** (for scripting):

```bash
# Show all prices
./prices.sh

# Show specific assets
./prices.sh --ticker BTC ETH SOL

# List all supported cryptocurrencies
./prices.sh --list

# Output in Beancount format
./prices.sh --beancount

# Filter and output for price file
./prices.sh --ticker BTC ETH SOL --beancount >> crypto_prices.beancount
```

**Advanced options:**

```bash
# Use specific date
./prices.sh --date 2025-10-27

# Different currency
./prices.sh --currency eur

# Multiple tickers with case-insensitive matching
./prices.sh --ticker btc Eth SoL
```

**Automation example** (cron job for daily updates):

```bash
# Edit crontab
crontab -e

# Add line to fetch prices daily at 9 AM
0 9 * * * cd /path/to/coinbean && ./prices.sh --beancount >> crypto_prices.beancount
```

## Updating Prices

> See [Helper Scripts](#helper-scripts) section for basic usage of `prices.sh`.

This section covers advanced price fetching features and automation.

### New Features

✨ **Table Display**: By default, prices are displayed in a formatted table showing:

- Ticker symbol
- Asset name
- Blockchain/chain (to distinguish assets with same ticker)
- Category (Layer-1, DEX, Liquid Staking, etc.)
- Current price

✨ **Chain Information**: Avoid ambiguity - see which chain each asset belongs to (e.g., USDC on Ethereum vs Multi-chain)

✨ **Case-Insensitive Filtering**: Use `--ticker btc` or `--ticker BTC` - both work!

✨ **Wrapper Script**: Use `./prices.sh` for a convenient interface with colored output

### Supported Cryptocurrencies

The script supports 110+ cryptocurrencies including:

- **Layer 1**: BTC, ETH, SOL, ADA, DOT, AVAX, ATOM, ALGO, XRP, XLM, NEAR, FTM, TON, APT, SUI, TRX, XTZ, EOS, FLOW, SEI, INJ, KAVA, THETA, KAS
- **Layer 2**: MATIC, OP, ARB, IMX, LRC, METIS
- **Stablecoins**: USDT, USDC, DAI, BUSD, TUSD
- **DeFi**: UNI, AAVE, MKR, COMP, SNX, CRV, SUSHI, RUNE, INCH (1inch), PENDLE, DYDX, GMX, RAY, JUP, ORCA
- **Liquid Staking**: LDO, STETH, RPL, RETH, EIGEN, JTO, JITOSOL, MNDE, MSOL
- **AI/ML**: FET, AGIX, OCEAN, TAO, RNDR
- **Gaming/Metaverse**: SAND, MANA, AXS, IMX, ENJ, GALA, BLUR, MAGIC
- **NFT Ecosystem**: APE, LOOKS, X2Y2, SUDO, BLUR, NFT
- **Bitcoin Ordinals/BRC-20**: ORDI, SATS, RATS, PUPS, TRAC
- **Storage/Infrastructure**: FIL, AR, GRT
- **RWA & Emerging**: ONDO, WLD, PYTH
- **Exchange Tokens**: BNB, CRO, FTT, HYPE
- **Meme Coins**: DOGE, SHIB, PEPE, FLOKI, BONK, WIF
- **Privacy**: XMR, ZEC
- **Others**: LINK, LTC, BCH, ETC, VET, HBAR, ICP

### Setting Up Automatic Price Updates

Create a daily cron job to automatically fetch prices:

```bash
# Edit crontab
crontab -e

# Add this line to fetch prices daily at 9 AM
0 9 * * * cd /path/to/finance/crypto && python3 fetch_prices.py >> crypto_prices.beancount
```

### Manual Price Entry

You can also manually add prices to `crypto_prices.beancount`:

```beancount
2025-10-27 price BTC 67500.00 USD
2025-10-27 price ETH 3250.00 USD
2025-10-27 price SOL 175.00 USD
```

### API Rate Limits

CoinGecko free tier has rate limits (~50 calls/minute). The script is designed to batch requests efficiently, fetching all prices in a single API call.

## Example Transactions

### Buying Crypto on an Exchange

```beancount
2025-01-15 * "Coinbase" "Buy Bitcoin"
  Assets:Crypto:Exchange:Coinbase:BTC     0.5 BTC {50000.00 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD  -25000.00 USD
  Expenses:Crypto:Trading:Fees                   50.00 USD
```

### Transferring to Cold Storage

```beancount
2025-01-16 * "Transfer to Ledger" "Move BTC to hardware wallet"
  Assets:Crypto:Wallet:Ledger:BTC            0.5 BTC
  Assets:Crypto:Exchange:Coinbase:BTC       -0.5 BTC
  Expenses:Crypto:Withdrawal:Fees          0.0001 BTC
```

### Staking Rewards

```beancount
2025-01-20 * "Staking Rewards" "ETH staking rewards"
  Assets:Crypto:Staking:ETH              0.05 ETH
  Income:Crypto:Staking:Rewards         -0.05 ETH {2500.00 USD}
```

### DeFi Lending

```beancount
2025-01-25 * "Aave" "Deposit USDC for lending"
  Assets:Crypto:DeFi:Aave:USDC              5000 USDC
  Assets:Crypto:Wallet:MetaMask:USDC       -5000 USDC
  Expenses:Crypto:Gas:Ethereum                 15.00 USD
```

### Buying an NFT

```beancount
2025-02-01 * "OpenSea" "Purchased Azuki #1234"
  Assets:Crypto:NFT:Ethereum:Azuki         1 AZUKI.1234 {5.5 ETH}
  Assets:Crypto:Wallet:MetaMask:ETH       -5.5 ETH
  Expenses:Crypto:Trading:Fees            0.165 ETH  ; 3% marketplace fee
  Expenses:Crypto:Gas:Ethereum            0.005 ETH  ; Gas fee
```

### Selling an NFT

```beancount
2025-03-15 * "OpenSea" "Sold Doodles #5678"
  Assets:Crypto:Wallet:MetaMask:ETH        8.0 ETH
  Assets:Crypto:NFT:Ethereum:Doodles      -1 DOODLES.5678 {6.0 ETH}
  Expenses:Crypto:Trading:Fees            0.24 ETH   ; 3% marketplace fee
  Expenses:Crypto:Gas:Ethereum            0.004 ETH
  Income:Crypto:Trading:CapitalGains     -2.0 ETH    ; Gain from NFT sale
```

### Bitcoin Ordinals

```beancount
2025-04-10 * "Magic Eden" "Inscribed NodeMonkes #42"
  Assets:Crypto:NFT:Bitcoin:NodeMonkes     1 NODEMONKES.42 {0.15 BTC}
  Assets:Crypto:Wallet:Electrum:BTC       -0.15 BTC
  Expenses:Crypto:Trading:Fees            0.003 BTC
```

### BRC-20 Token Purchase

```beancount
2025-04-20 * "UniSat" "Bought ORDI tokens"
  Assets:Crypto:Exchange:Binance:ORDI      100 ORDI {35.00 USD}
  Assets:Crypto:Exchange:Binance:Cash:USD -3500.00 USD
  Expenses:Crypto:Trading:Fees               10.00 USD
```

## Supported Assets

### Layer-1 Blockchains

BTC, ETH, SOL, ADA, DOT, AVAX, ATOM, ALGO, XRP, XLM, NEAR, FTM, TON, APT, SUI, LTC, BCH, ETC, and more

### Layer-2 Solutions

MATIC, OP, ARB

### Stablecoins

USDT, USDC, DAI, BUSD, TUSD

### DeFi Tokens

UNI, AAVE, MKR, COMP, SNX, CRV, SUSHI

### Exchange Tokens

BNB, CRO, FTT

### Perpetual DEX

HYPE (Hyperliquid), DYDX (dYdX), GMX

### Solana DEX

RAY (Raydium), JUP (Jupiter), ORCA (Orca)

### Liquid Staking & Restaking

- **Ethereum**: LDO (Lido), STETH, RPL (Rocket Pool), RETH, EIGEN (EigenLayer)
- **Solana**: JTO (Jito), JITOSOL, MNDE (Marinade), MSOL

### NFT Ecosystem Tokens

APE (ApeCoin), LOOKS (LooksRare), X2Y2, SUDO (Sudoswap), BLUR (Blur), NFT (APENFT)

### Bitcoin Ordinals & BRC-20

ORDI (Ordinals), SATS, RATS, PUPS (Bitcoin Puppets), TRAC

### NFT Collections Supported

- **Ethereum**: BAYC, MAYC, Azuki, CloneX, Doodles, Pudgy Penguins, Moonbirds, Cryptopunks, Meebits, Art Blocks, PROOF Collective
- **Solana**: DeGods, y00ts, Mad Lads, Solana Monkey Business, Okay Bears, Tensorians
- **Bitcoin Ordinals**: NodeMonkes, Bitcoin Puppets, Quantum Cats, Ordinal Inscriptions
- **Polygon**: Reddit Collectible Avatars
- **Base**: Based Fellas

### Other Categories

Meme coins (DOGE, SHIB, PEPE, BONK, WIF, FLOKI), Privacy coins (XMR, ZEC), Oracles (LINK, PYTH), AI tokens (FET, AGIX, TAO, RNDR), Gaming & Metaverse (SAND, MANA, AXS, IMX), Storage (FIL, AR), RWA (ONDO), and many more

## Customization Guide

Coinbean's modular structure makes it easy to customize for your specific needs. This section explains how to add new exchanges, wallets, protocols, and cryptocurrencies.

### Understanding the Modular Structure

Coinbean organizes accounts into separate files for better maintainability:

| File                    | Purpose                              | When to Edit             |
| ----------------------- | ------------------------------------ | ------------------------ |
| `crypto_main.beancount` | Commodity definitions, core accounts | Add new cryptocurrencies |
| `exchanges.beancount`   | Centralized exchange accounts        | Add new exchanges        |
| `chains.beancount`      | Wallets and native staking           | Add wallets or staking   |
| `defi.beancount`        | DeFi protocols                       | Add DeFi protocols       |
| `tx_2025.beancount`     | Current year transactions            | Record your transactions |

### Adding a New Exchange

**File to edit:** `exchanges.beancount`

**Template:**

```beancount
;; ========================================
;; YOUR EXCHANGE NAME
;; ========================================

;; Fiat accounts
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Cash:EUR

;; Cryptocurrency accounts
2020-01-01 open Assets:Crypto:Exchange:YourExchange:BTC
2020-01-01 open Assets:Crypto:Exchange:YourExchange:ETH
2020-01-01 open Assets:Crypto:Exchange:YourExchange:SOL
2020-01-01 open Assets:Crypto:Exchange:YourExchange:USDC
2020-01-01 open Assets:Crypto:Exchange:YourExchange:USDT

;; Generic account for other tokens
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Other
```

**Example - Adding Bitfinex:**

```beancount
;; ========================================
;; BITFINEX
;; ========================================

2020-01-01 open Assets:Crypto:Exchange:Bitfinex:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:Bitfinex:BTC
2020-01-01 open Assets:Crypto:Exchange:Bitfinex:ETH
2020-01-01 open Assets:Crypto:Exchange:Bitfinex:USDT
```

**Tips:**

- Only create accounts for assets you actually hold
- Use consistent naming (CamelCase for exchange names)
- Group related accounts with comments
- The `Other` account is useful for tokens you don't want to track individually

### Adding a New Wallet

**File to edit:** `chains.beancount`

**Hardware Wallet Example:**

```beancount
;; ========================================
;; COLDCARD (Bitcoin Hardware Wallet)
;; ========================================

2020-01-01 open Assets:Crypto:Wallet:Coldcard:BTC
```

**Software Wallet Example:**

```beancount
;; ========================================
;; RABBY WALLET (Multi-chain)
;; ========================================

2020-01-01 open Assets:Crypto:Wallet:Rabby:ETH
2020-01-01 open Assets:Crypto:Wallet:Rabby:MATIC
2020-01-01 open Assets:Crypto:Wallet:Rabby:Tokens
```

**Mobile Wallet Example:**

```beancount
;; ========================================
;; COINBASE WALLET (Mobile App)
;; ========================================

2020-01-01 open Assets:Crypto:Wallet:CoinbaseWallet:ETH
2020-01-01 open Assets:Crypto:Wallet:CoinbaseWallet:Tokens
```

**Account Naming Convention:**

```
Assets:Crypto:Wallet:{WalletName}:{Asset}
                     └─────┬─────┘  └──┬──┘
                         Wallet      Specific
                          Name      token/chain
```

### Adding Native Staking

**File to edit:** `chains.beancount`

**Template:**

```beancount
;; ========================================
;; STAKING - {BLOCKCHAIN NAME}
;; ========================================

;; Delegated/staked assets
2020-01-01 open Assets:Crypto:Staking:CHAIN:Delegated

;; Pending/unbonding assets
2020-01-01 open Assets:Crypto:Staking:CHAIN:Unbonding

;; Staking rewards accumulation
2020-01-01 open Assets:Crypto:Staking:CHAIN:Rewards
```

**Example - Avalanche Staking:**

```beancount
;; ========================================
;; STAKING - AVALANCHE
;; ========================================

2020-01-01 open Assets:Crypto:Staking:AVAX:Delegated
2020-01-01 open Assets:Crypto:Staking:AVAX:Rewards
```

**Example Transaction - Stake AVAX:**

```beancount
2025-01-15 * "Stake AVAX" "Delegate to validator"
  Assets:Crypto:Staking:AVAX:Delegated    100 AVAX
  Assets:Crypto:Wallet:Avalanche:AVAX    -100 AVAX
  Expenses:Crypto:Gas:Avalanche           0.01 AVAX
```

### Adding DeFi Protocols

**File to edit:** `defi.beancount`

**Lending Protocol Example:**

```beancount
;; ========================================
;; VENUS PROTOCOL (BSC Lending)
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Venus:BNB
2020-01-01 open Assets:Crypto:DeFi:Venus:USDT
2020-01-01 open Assets:Crypto:DeFi:Venus:Supplied
2020-01-01 open Liabilities:Crypto:DeFi:Venus:Borrowed
```

**DEX Liquidity Pool Example:**

```beancount
;; ========================================
;; ORCA (Solana DEX)
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Orca:SOL
2020-01-01 open Assets:Crypto:DeFi:Orca:USDC
2020-01-01 open Assets:Crypto:DeFi:Orca:LP-Tokens
  name: "Orca LP Tokens"
2020-01-01 open Assets:Crypto:DeFi:Orca:ORCA
  name: "ORCA governance token"
```

**Perpetual DEX Example:**

```beancount
;; ========================================
;; VERTEX PROTOCOL (Arbitrum Perps)
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Vertex:USDC
2020-01-01 open Assets:Crypto:DeFi:Vertex:Positions
  name: "Active perpetual positions"
2020-01-01 open Assets:Crypto:DeFi:Vertex:VRTX
```

**Liquid Staking Example:**

```beancount
;; ========================================
;; BENQI (Avalanche Liquid Staking)
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Benqi:SAVAX
  name: "Staked AVAX (liquid)"
2020-01-01 open Assets:Crypto:DeFi:Benqi:QI
  name: "QI governance token"
```

### Adding a New Cryptocurrency

**File to edit:** `crypto_main.beancount`

**Template:**

```beancount
2020-01-01 commodity TICKER
  name: "Full Name"
  asset-class: "cryptocurrency"
  blockchain: "Blockchain Name"
  category: "Category"
  export: "CASH"
```

**Layer-1 Blockchain Example:**

```beancount
2020-01-01 commodity ALGO
  name: "Algorand"
  asset-class: "cryptocurrency"
  blockchain: "Algorand"
  category: "Layer-1"
  export: "CASH"
```

**DeFi Token Example:**

```beancount
2020-01-01 commodity CAKE
  name: "PancakeSwap"
  asset-class: "cryptocurrency"
  blockchain: "BNB Chain"
  category: "DeFi"
  export: "CASH"
```

**Liquid Staking Token Example:**

```beancount
2020-01-01 commodity CBETH
  name: "Coinbase Wrapped Staked ETH"
  asset-class: "cryptocurrency"
  blockchain: "Ethereum"
  category: "Liquid Staking"
  pegged-to: "ETH"
  export: "CASH"
```

**Important Rules:**

- ✅ Ticker must be ALL UPPERCASE
- ✅ Cannot start with a number (use `INCH` instead of `1INCH`)
- ✅ Cannot contain lowercase letters or special characters except underscore
- ✅ Use descriptive categories: Layer-1, Layer-2, DeFi, Stablecoin, NFT, Meme, etc.

**Common Categories:**

- `Layer-1` - Base blockchain (BTC, ETH, SOL)
- `Layer-2` - Scaling solution (MATIC, OP, ARB)
- `DeFi` - Decentralized finance (UNI, AAVE, CRV)
- `Liquid Staking` - Staking derivatives (LDO, RPL, JTO)
- `DEX` - Decentralized exchange tokens (RAY, JUP)
- `Perpetual DEX` - Perp platforms (DYDX, GMX, HYPE)
- `Stablecoin` - Pegged to fiat (USDC, USDT, DAI)
- `NFT Marketplace` - NFT platforms (BLUR, LOOKS)
- `BRC-20` - Bitcoin Ordinals tokens (ORDI, SATS)
- `AI` - AI/ML tokens (FET, AGIX, TAO)
- `Gaming` - Gaming tokens (AXS, GALA)
- `Meme` - Meme coins (DOGE, SHIB, BONK)

### Adding NFT Collections

**File to edit:** `chains.beancount` (or create `nft.beancount`)

**Template:**

```beancount
;; NFT Collections - {BLOCKCHAIN}
2020-01-01 open Assets:Crypto:NFT:Blockchain:CollectionName
  name: "Full Collection Name"
```

**Example:**

```beancount
;; NFT Collections - Ethereum
2020-01-01 open Assets:Crypto:NFT:Ethereum:Pudgy
  name: "Pudgy Penguins"

;; NFT Collections - Solana
2020-01-01 open Assets:Crypto:NFT:Solana:MadLads

;; NFT Collections - Bitcoin Ordinals
2020-01-01 open Assets:Crypto:NFT:Bitcoin:NodeMonkes
```

### Adding Price Fetching Support

**File to edit:** `fetch_prices.py`

To add automatic price fetching for a new cryptocurrency:

1. Find the CoinGecko ID at https://www.coingecko.com/
2. Add to the `ASSETS` list in `fetch_prices.py`:

```python
ASSETS = [
    # ... existing assets ...
    Asset('YOUR', 'Your Coin Name', 'Ethereum', 'DeFi', 'your-coin-coingecko-id'),
]
```

**Example:**

```python
Asset('CAKE', 'PancakeSwap', 'BNB Chain', 'DEX', 'pancakeswap-token'),
```

**Structure:**

- `ticker` - Symbol in Beancount (UPPERCASE)
- `name` - Full name of the asset
- `chain` - Blockchain (helps distinguish multi-chain assets)
- `category` - Category (Layer-1, DEX, etc.)
- `coingecko_id` - CoinGecko API identifier (from URL slug)

### Disabling Modules

If you don't use certain exchanges or protocols, you can comment them out in `crypto_main.beancount`:

```beancount
;; Centralized Exchanges
include "exchanges.beancount"

;; Blockchain Wallets & Native Staking
include "chains.beancount"

;; DeFi Protocols & Liquid Staking
; include "defi.beancount"  ; <-- Commented out if you don't use DeFi
```

### Validation

After making changes, always validate your ledger:

```bash
bean-check crypto_main.beancount
```

If there are no errors, you're good to go! If there are errors, the output will tell you exactly what line has the problem.

## Transaction Examples

The `crypto_examples.beancount` file includes 20+ comprehensive examples covering:

1. Buying crypto with fiat (market buy)
2. Selling crypto for fiat
3. Crypto-to-crypto trades
4. Depositing fiat to exchange
5. Withdrawing crypto to cold wallet
6. Depositing crypto from cold wallet
7. Staking rewards
8. Trading fees
9. Gas fees (Ethereum)
10. DeFi liquidity provision
11. DeFi yield earning
12. Airdrops
13. Buying stablecoins
14. Cross-exchange transfers
15. Dollar-cost averaging (DCA)
16. Mining rewards
17. DeFi borrowing
18. Paying back DeFi loans
19. NFT purchases
20. Exchange token rewards
21. Converting dust to BNB

## Tax Reporting

### Taxable Events

1. **Capital Gains/Losses**

   - Selling crypto for fiat
   - Trading one crypto for another
   - Using crypto to buy goods/services

2. **Income**
   - Staking rewards
   - Mining rewards
   - DeFi interest/yield
   - Airdrops
   - Referral bonuses

### Recording for Tax Purposes

Always track:

- **Cost basis**: Original purchase price `{PRICE USD}`
- **Sale price**: Current market price `@ PRICE USD`
- **Capital gains**: Record in `Income:Crypto:Trading:CapitalGains`
- **Income**: Record in appropriate `Income:Crypto:*` accounts
- **Fees**: Track separately in `Expenses:Crypto:*` accounts

### Generating Tax Reports

```bash
# View all capital gains
bean-query crypto_main.beancount "
  SELECT date, account, sum(cost(position)), sum(value(position))
  WHERE account ~ 'CapitalGains'
  GROUP BY date, account
  ORDER BY date
"

# View all staking income
bean-query crypto_main.beancount "
  SELECT date, account, sum(position)
  WHERE account ~ 'Staking:Rewards'
  ORDER BY date
"
```

## Reporting

Generate various reports using Beancount commands:

```bash
# Validate your ledger
bean-check crypto_main.beancount

# Check account balances
bean-report crypto_main.beancount balances

# View net worth
bean-report crypto_main.beancount networth

# Export to CSV
bean-report crypto_main.beancount holdings > holdings.csv

# Generate income statement
bean-report crypto_main.beancount income_statement

# Query specific data
bean-query crypto_main.beancount "SELECT account, sum(position) WHERE account ~ 'BTC'"

# Start Fava on custom port
./run.sh -p 5003
```

## Security

### Protecting Your Financial Data with Git

**IMPORTANT**: If you're using Git to version control your Beancount files, your transaction data contains sensitive financial information. **You MUST encrypt your files before committing them to any repository.**

**Recommended approach:**

1. **Use git-crypt** (recommended) or **git-secret** to encrypt sensitive files
2. Encrypt all `.beancount` files that contain actual transaction data
3. Add encryption keys to `.gitignore` to prevent accidental commits

**Example setup with git-crypt:**

```bash
# Install git-crypt
brew install git-crypt  # macOS
# or: sudo apt-get install git-crypt  # Linux

# Initialize git-crypt in your repository
cd /path/to/coinbean
git-crypt init

# Specify which files to encrypt in .gitattributes
echo "*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
echo "tx_*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes

# Add collaborators (optional)
git-crypt add-gpg-user YOUR_GPG_KEY_ID
```

**What to encrypt:**

- ✅ All transaction files (`tx_*.beancount`)
- ✅ Account files with real balances (`exchanges.beancount`, `chains.beancount`, `defi.beancount`)
- ✅ Price files with your actual positions
- ❌ Template/example files can remain unencrypted

**Additional security measures:**

- Use separate branches for sensitive data vs. templates
- Never push unencrypted financial data to public repositories
- Review all commits before pushing to ensure no sensitive data is exposed
- Consider using private repositories even with encryption

## Best Practices

1. **Record Transactions Promptly**: Log transactions as they happen - don't let them pile up
2. **Track Every Fee**: Withdrawal, trading, and gas fees are all tax-deductible expenses
3. **Update Prices Regularly**: Weekly minimum, daily for active traders
4. **Back Up Your Data**: Commit to git regularly and keep exchange export files
5. **Reconcile Regularly**: Compare with exchange balances monthly
6. **Document Complex Transactions**: Add notes to unusual transactions and DeFi positions
7. **Separate Hot and Cold Storage**: Use different accounts and track transfer fees
8. **Plan for Taxes**: Record cost basis accurately and consult a tax professional
9. **Use Consistent Accounts**: Stick to the naming convention and keep it organized
10. **Privacy**: Never commit files with real transaction data to public repositories

## Troubleshooting

### Common Issues

**"bean-check reports errors"**

- Check for typos in account names
- Ensure all transactions balance
- Verify commodity symbols match

**"Prices not showing in Fava"**

- Update `crypto_prices.beancount`
- Ensure date format is YYYY-MM-DD
- Check commodity symbols match exactly

**"Balance doesn't match exchange"**

- Review all transactions chronologically
- Check for missing fees
- Verify transfer amounts

**"Fava won't start"**

- Ensure Fava is installed: `pip3 install fava`
- Check port isn't in use: try `./run.sh -p 5003`
- Validate ledger: `bean-check crypto_main.beancount`

### Getting Help

- **Beancount Documentation**: https://beancount.github.io/docs/
- **Fava Documentation**: https://beancount.github.io/fava/
- **Beancount Mailing List**: https://groups.google.com/forum/#!forum/beancount
- **Fava GitHub**: https://github.com/beancount/fava

## Advanced Topics

### Custom Queries with bean-query

Create custom reports with `bean-query`:

```bash
# Total portfolio value
bean-query crypto_main.beancount "
  SELECT sum(convert(value(position), 'USD')) AS total_value
  WHERE account ~ 'Assets:Crypto'
"

# Top 5 holdings by value
bean-query crypto_main.beancount "
  SELECT account, sum(convert(value(position), 'USD')) AS value
  WHERE account ~ 'Assets:Crypto'
  GROUP BY account
  ORDER BY value DESC
  LIMIT 5
"

# Monthly staking income
bean-query crypto_main.beancount "
  SELECT year(date), month(date), sum(position)
  WHERE account = 'Income:Crypto:Staking:Rewards'
  GROUP BY year(date), month(date)
  ORDER BY year(date), month(date)
"
```

### Extending the Price Fetcher

The `fetch_prices.py` script can be easily extended. To add a new cryptocurrency:

1. Find the CoinGecko ID at https://www.coingecko.com/
2. Add it to the `ASSETS` list in `fetch_prices.py` with chain and category info
3. Add the commodity definition to `crypto_main.beancount`

Example:

```python
# In fetch_prices.py - Add to the ASSETS list
ASSETS = [
    # ... existing assets ...
    Asset('NEW', 'New Coin Name', 'Ethereum', 'DeFi', 'new-coin-coingecko-id'),
]
```

The Asset structure includes:

- `ticker`: Symbol used in Beancount (uppercase)
- `name`: Full name of the asset
- `chain`: Blockchain/network (helps distinguish same ticker on different chains)
- `category`: Type (Layer-1, DEX, Liquid Staking, etc.)
- `coingecko_id`: CoinGecko API identifier

## Resources

Visit [coinbean.org/docs](http://coinbean.org/docs) to learn more about:

- Advanced transaction patterns
- Tax reporting strategies
- Integration with other tools
- Community best practices

**Project Links:**

- 📦 [GitHub Repository](https://github.com/qai-lab/coinbean) - Source code, issues, and contributions
- 📋 [Release Notes](https://github.com/qai-lab/coinbean/releases) - Version history and changelog
- 🌐 [Coinbean Website](https://coinbean.org/) - Official website and documentation
- 🐦 [Coinbean on X/Twitter](https://x.com/CoinbeanAI) - Follow for updates and news
- 📚 [Beancount Documentation](https://beancount.github.io/docs/) - Learn about Beancount
- 🖥️ [Fava - Web Interface](https://github.com/beancount/fava) - Beancount web interface
- 💬 [Plain Text Accounting](https://plaintextaccounting.org/) - Community and resources

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. Areas for contribution:

- Additional exchange templates
- More DeFi protocols
- Automation scripts for importing transactions
- Documentation improvements

## Author

**Coinbean** is created and maintained by:

- **Boyuan Qian**
  - 🐙 GitHub: [@boyuanqian](https://github.com/boyuanqian)
  - 🐦 X/Twitter: [@boyuan_qian](https://x.com/boyuan_qian)
  - 🏢 Organization: [QAI Lab](https://github.com/qai-lab)

**QAI Lab**

- 🌐 Website: [qai.io](https://qai.io)
- 🐙 GitHub: [@qai-lab](https://github.com/qai-lab)
- 🐦 X/Twitter: [@qai_lab](https://x.com/qai_lab)

## License

MIT License - Copyright (c) 2025 Boyuan Qian and QAI Lab

See the [LICENSE](LICENSE) file for details.

This template is provided as-is for personal use. Customize as needed for your portfolio tracking needs.

## Disclaimer

This is a personal finance tracking tool. It does not provide:

- Financial advice
- Tax advice
- Investment recommendations

Always consult with qualified professionals for financial and tax matters. Cryptocurrency investments are risky and may result in loss of capital.

---

**Happy Tracking! 📊💰**
