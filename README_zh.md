# Coinbean

基于 [Beancount](https://github.com/beancount/beancount) 复式记账系统构建的综合加密货币投资组合跟踪系统。

**由 [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab) 创建**

[English](README.md) | 简体中文

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/coinbean_org](https://x.com/coinbean_org)

---

## Coinbean 是什么？

Coinbean 是一个结构化的 Beancount 账本模板，用于跟踪以下平台的加密货币投资组合：

- 多个中心化交易所（Coinbase、Binance、Kraken 等）
- 硬件和软件钱包（Ledger、Trezor、MetaMask、Phantom）
- DeFi 协议（Aave、Compound、Uniswap、Raydium、Jupiter 等）
- 永续合约 DEX（Hyperliquid、dYdX、GMX）
- 流动性质押协议（Lido、Rocket Pool、Jito、Marinade）
- 再质押协议（EigenLayer、Solayer）
- NFT 收藏品（BAYC、Azuki、DeGods、比特币序数等）
- 质押和流动性挖矿活动
- 110+ 种加密货币，涵盖 Layer-1、Layer-2、DeFi、稳定币、NFT 等

## 功能特性

- **全面的资产覆盖**：预配置支持 110+ 种加密货币和 NFT 收藏品，包括 BTC、ETH、SOL 等
- **多交易所支持**：跟踪 10+ 个主要交易所的资产（Coinbase、Binance、Kraken、Gemini、Crypto.com 等）
- **DeFi 集成**：记录借贷、流动性池和质押
- **NFT 跟踪**：支持以太坊、Solana、比特币序数、Polygon 和 Base 上的热门 NFT 收藏品
- **比特币序数和 BRC-20**：跟踪序数铭文和 BRC-20 代币（ORDI、SATS 等）
- **精确的小数处理**：为聪、gwei 和其他小单位配置了容差
- **复式记账**：遵循正确的簿记原则提供完整的审计跟踪
- **税务报告就绪**：跟踪来自各种来源的资本利得、费用和收入
- **Web 界面**：使用 Fava 实现精美的可视化
- **简易设置**：包含自动化设置和运行脚本

## ⚡ 快速参考

| 脚本 | 命令 | 用途 |
|--------|---------|---------|
| **设置** | `./setup.sh` | 安装 Beancount 和 Fava，验证账本 |
| **运行 Fava** | `./run.sh` | 在 http://localhost:5002 启动 Web 界面 |
| **获取价格** | `./prices.sh` | 获取当前加密货币价格（交互式菜单） |

详细文档请参阅[辅助脚本](#辅助脚本)部分。

## 快速开始

### 前置要求

- Python 3.7+
- pip（Python 包管理器）

### 三个简单步骤

**步骤 1：设置**

```bash
cd /path/to/coinbean
./setup.sh
```

安装 Beancount、Fava 并验证您的账本文件。

**步骤 2：启动 Fava**

```bash
./run.sh
```

在 http://localhost:5002 启动 Web 界面。

**步骤 3：获取价格**

```bash
./prices.sh
```

交互式菜单获取当前加密货币价格。

> 📚 详细文档请参阅[辅助脚本](#辅助脚本)部分。

### 手动安装（替代方案）

如果您喜欢手动安装：

```bash
pip install beancount fava

# 验证安装
bean-check crypto_main.beancount

# 启动 Fava
fava -p 5002 crypto_main.beancount
```

### 首次使用步骤

1. **查看示例**：打开 `crypto_examples.beancount` 查看 20+ 个交易示例
2. **更新价格**：运行 `./prices.sh` 获取当前市场价格（[查看详情](#3-pricessh---交互式价格获取器)）
3. **添加您的交易**：开始在 `tx_2025.beancount` 中记录
4. **自定义账户**：修改模块化文件（`exchanges.beancount`、`chains.beancount`、`defi.beancount`）以匹配您的设置
5. **浏览 Fava**：打开 http://localhost:5002 可视化您的投资组合（[查看详情](#2-runsh---启动-fava-web-界面)）

## 文件结构

Coinbean 使用**模块化结构**以便更好地组织：

```
crypto/
├── crypto_main.beancount       # 主账本，包含商品定义和导入
├── exchanges.beancount         # 中心化交易所账户（Coinbase、Binance 等）
├── chains.beancount            # 区块链钱包和原生质押
├── defi.beancount              # DeFi 协议、流动性质押、再质押
├── crypto_prices.beancount     # 所有资产的价格数据
├── tx_2024.beancount           # 2024 年交易
├── tx_2025.beancount           # 2025 年交易
├── crypto_examples.beancount   # 20+ 个示例交易（参考）
├── fetch_prices.py             # 从 CoinGecko 自动获取价格
├── prices.sh                   # fetch_prices.py 的便捷包装器
├── setup.sh                    # 自动化设置和安装脚本
├── run.sh                      # 启动 Fava Web 界面
└── README.md                   # 本文件
```

## 账户结构

Coinbean 遵循 Beancount 的**复式记账**原则，采用分层账户结构：

```
Assets:Crypto
├── Exchange                    # 中心化交易所
│   ├── Coinbase
│   │   ├── Cash:USD           # 法币余额
│   │   ├── BTC                # 比特币余额
│   │   ├── ETH                # 以太坊余额
│   │   └── Other              # 其他代币
│   ├── Binance
│   ├── Kraken
│   └── [10+ 交易所...]
│
├── Wallet                      # 自托管钱包
│   ├── Ledger                 # 硬件钱包
│   │   ├── BTC
│   │   └── ETH
│   ├── MetaMask               # 软件钱包
│   ├── Phantom
│   └── [更多钱包...]
│
├── Staking                     # 原生区块链质押
│   ├── ETH
│   │   ├── Delegated          # 质押金额
│   │   └── Rewards            # 赚取的奖励
│   ├── SOL
│   ├── ADA
│   └── [更多链...]
│
├── DeFi                        # DeFi 协议
│   ├── Aave                   # 借贷
│   │   ├── USDC
│   │   └── ETH
│   ├── Uniswap                # DEX
│   │   └── LPTokens
│   ├── Hyperliquid            # 永续合约 DEX
│   ├── Lido                   # 流动性质押
│   │   └── STETH
│   └── [更多协议...]
│
└── NFT                         # NFT 收藏品
    ├── Ethereum
    │   ├── BAYC
    │   ├── Azuki
    │   └── [更多收藏品...]
    ├── Solana
    │   ├── DeGods
    │   └── MadLads
    └── Bitcoin
        └── NodeMonkes

Liabilities:Crypto
└── DeFi                        # DeFi 贷款
    ├── Aave:Borrowed
    └── Compound:Borrowed

Income:Crypto
├── Staking:Rewards             # 质押收入
├── Mining:Rewards              # 挖矿收入
├── Airdrops                    # 空投代币
├── Referrals                   # 推荐奖金
└── Trading:CapitalGains        # 已实现收益

Expenses:Crypto
├── Trading:Fees                # 交易所费用
├── Withdrawal:Fees             # 提款费用
├── Gas                         # 交易费用
│   ├── Ethereum
│   ├── Solana
│   └── [其他链...]
└── Trading:Losses              # 已实现损失

Equity:Opening-Balances         # 初始余额
```

### 账户命名约定

Coinbean 使用一致的分层命名结构：

```
Assets:Crypto:{类型}:{平台}:{资产}
             └──┬──┘ └────┬────┘ └──┬──┘
              类型     平台     具体代币
```

**示例：**
- `Assets:Crypto:Exchange:Coinbase:BTC` - Coinbase 上的比特币
- `Assets:Crypto:Wallet:Ledger:ETH` - Ledger 上的以太坊
- `Assets:Crypto:DeFi:Aave:USDC` - 存入 Aave 的 USDC
- `Assets:Crypto:Staking:SOL:Delegated` - 质押的 Solana
- `Assets:Crypto:NFT:Ethereum:BAYC` - Bored Ape Yacht Club NFT

**提示：**
- 平台名称使用驼峰命名法（例如 `MetaMask` 而不是 `metamask`）
- 资产代码保持大写（例如 `BTC`、`ETH`）
- 在所有交易中保持一致

### 模块化组织说明

**🎯 crypto_main.beancount** - 您账本的核心

这是将所有内容联系在一起的主入口点。它包含：
- **110+ 种加密货币商品定义**（BTC、ETH、SOL、NFT 代币、BRC-20 等）
- **收入/支出/权益账户**（资本利得、质押奖励、Gas 费用等）
- **模块导入**通过 `include` 语句
- **核心配置**（容差、运营货币、插件）

**何时编辑：**添加新加密货币、更改容差、启用/禁用模块

**💱 exchanges.beancount** - 中心化交易所账户

预配置了 10+ 个主要交易所的账户：
- **一线**：Coinbase、Binance、Kraken、Gemini
- **二线**：Crypto.com、KuCoin、Bybit、OKX、HTX、Gate.io

每个交易所都有：
- 法币账户（USD、EUR）
- 主要加密货币账户（BTC、ETH、SOL、稳定币）
- 通用"Other"账户用于山寨币

**何时编辑：**添加您使用的新交易所，删除您不使用的交易所

**⛓️ chains.beancount** - 自托管和原生质押

包含以下账户：
- **硬件钱包**：Ledger、Trezor
- **软件钱包**：MetaMask、Phantom、Sui Wallet、Trust Wallet 等
- **原生质押**：ETH、SOL、ADA、DOT、ATOM、SUI、AVAX 的直接质押
- **NFT 收藏品**：以太坊、Solana、比特币序数、Polygon、Base

**何时编辑：**添加新钱包、跟踪新 NFT 收藏品、设置原生质押

**🏦 defi.beancount** - DeFi 协议和流动性质押

全面的 DeFi 覆盖：
- **借贷**：Aave、Compound、MakerDAO
- **DEX**：Uniswap、SushiSwap、Curve、PancakeSwap、Raydium、Jupiter、Orca
- **永续合约 DEX**：Hyperliquid、dYdX、GMX
- **流动性质押**：Lido（ETH）、Rocket Pool（ETH）、Jito（SOL）、Marinade（SOL）
- **再质押**：EigenLayer、Solayer、Renzo、Ether.fi

**何时编辑：**添加您使用的新 DeFi 协议、跟踪流动性头寸

**💰 tx_2024.beancount 和 tx_2025.beancount** - 交易历史

您的实际交易记录，按年份分开以便于管理。

**何时编辑：**在记录加密货币交易时每日/每周更新

**📊 crypto_prices.beancount** - 价格数据

用于准确投资组合估值的历史价格数据。

**何时编辑：**
- 通过 `./prices.sh --beancount >> crypto_prices.beancount` 自动更新
- 为 CoinGecko 上没有的资产或历史价格手动更新

**📚 crypto_examples.beancount** - 学习资源

20+ 个示例交易，展示以下最佳实践：
- 交易所交易、钱包转账、质押、DeFi 操作、NFT 交易等

**何时使用：**当您不确定如何记录某种交易类型时参考

---

**💡 自定义提示：**您可以在 `crypto_main.beancount` 中注释掉整个模块以保持账本专注：

```beancount
;; 仅包含您实际使用的模块
include "exchanges.beancount"    ; ✓ 使用交易所
include "chains.beancount"       ; ✓ 使用钱包
; include "defi.beancount"       ; ✗ 不使用 DeFi（已注释）
```

## 辅助脚本

Coinbean 包含三个强大的辅助脚本，使管理加密货币投资组合更加容易。

### 1. `setup.sh` - 自动化安装和设置

设置脚本自动处理所有安装和配置。

**功能：**
- 检查 Python 3 安装
- 安装 Beancount 和 Fava 包
- 验证账本文件语法
- 可选安装价格获取依赖项（requests 库）
- 验证一切正常工作

**使用方法：**
```bash
./setup.sh
```

**首次设置：**
```bash
cd /path/to/coinbean
./setup.sh
```

脚本将通过清晰的提示和错误消息指导您完成安装过程。

**预期内容：**
1. Python 版本检查
2. 包安装（可能需要 sudo/管理员权限）
3. 使用 `bean-check` 验证账本
4. 成功消息和后续步骤

### 2. `run.sh` - 启动 Fava Web 界面

运行脚本启动 Fava Web 界面以可视化您的投资组合。

**功能：**
- 检查 Fava 是否已安装
- 在启动前验证您的账本文件
- 在端口 5002 上启动 Fava
- 自动打开默认浏览器（可选）

**使用方法：**
```bash
./run.sh
```

**然后在浏览器中打开：**
```
http://localhost:5002
```

**停止服务器：**
在运行 run.sh 的终端中按 `Ctrl+C`。

**自定义端口：**
编辑 `run.sh` 并更改脚本中的端口号：
```bash
fava -p 5002 crypto_main.beancount  # 将 5002 更改为您喜欢的端口
```

**Fava 功能：**
- 带账户余额的精美仪表板
- 交互式图表和图形
- 收入/支出报告
- 资产负债表和净值跟踪
- 自定义报告的查询编辑器

### 3. `prices.sh` - 交互式价格获取器

价格获取脚本从 CoinGecko API 获取当前加密货币价格。

**功能：**
- 获取 110+ 种加密货币的实时价格
- 在带有链信息的格式化表格中显示价格
- 支持按特定代码过滤
- 可以输出 Beancount 格式以供直接使用
- 无需 API 密钥（使用 CoinGecko 免费层）

**交互模式**（推荐）：
```bash
./prices.sh
```

您将看到一个菜单：
```
选择一个选项：
1. 显示所有加密货币价格
2. 显示特定代码
3. 列出所有支持的资产
4. 退出
```

**命令行模式**（用于脚本）：
```bash
# 显示所有价格
./prices.sh

# 显示特定资产
./prices.sh --ticker BTC ETH SOL

# 列出所有支持的加密货币
./prices.sh --list

# 输出 Beancount 格式
./prices.sh --beancount

# 过滤并输出到价格文件
./prices.sh --ticker BTC ETH SOL --beancount >> crypto_prices.beancount
```

**高级选项：**
```bash
# 使用特定日期
./prices.sh --date 2025-10-27

# 不同货币
./prices.sh --currency eur

# 多个代码（不区分大小写匹配）
./prices.sh --ticker btc Eth SoL
```

**自动化示例**（每日更新的 cron 作业）：
```bash
# 编辑 crontab
crontab -e

# 添加行以在上午 9 点每天获取价格
0 9 * * * cd /path/to/coinbean && ./prices.sh --beancount >> crypto_prices.beancount
```

## 更新价格

> 基本使用 `prices.sh` 请参阅[辅助脚本](#辅助脚本)部分。

本节涵盖高级价格获取功能和自动化。

### 新功能

✨ **表格显示**：默认情况下，价格以格式化表格显示，显示：
- 代码符号
- 资产名称
- 区块链/链（用于区分具有相同代码的资产）
- 类别（Layer-1、DEX、流动性质押等）
- 当前价格

✨ **链信息**：避免歧义 - 查看每个资产属于哪条链（例如，以太坊上的 USDC 与多链）

✨ **不区分大小写的过滤**：使用 `--ticker btc` 或 `--ticker BTC` - 都可以！

✨ **包装脚本**：使用 `./prices.sh` 获得带彩色输出的便捷界面

### 支持的加密货币

该脚本支持 110+ 种加密货币，包括：
- **Layer 1**：BTC、ETH、SOL、ADA、DOT、AVAX、ATOM、ALGO、XRP、XLM、NEAR、FTM、TON、APT、SUI、TRX、XTZ、EOS、FLOW、SEI、INJ、KAVA、THETA、KAS
- **Layer 2**：MATIC、OP、ARB、IMX、LRC、METIS
- **稳定币**：USDT、USDC、DAI、BUSD、TUSD
- **DeFi**：UNI、AAVE、MKR、COMP、SNX、CRV、SUSHI、RUNE、INCH（1inch）、PENDLE、DYDX、GMX、RAY、JUP、ORCA
- **流动性质押**：LDO、STETH、RPL、RETH、EIGEN、JTO、JITOSOL、MNDE、MSOL
- **AI/ML**：FET、AGIX、OCEAN、TAO、RNDR
- **游戏/元宇宙**：SAND、MANA、AXS、IMX、ENJ、GALA、BLUR、MAGIC
- **NFT 生态系统**：APE、LOOKS、X2Y2、SUDO、BLUR、NFT
- **比特币序数/BRC-20**：ORDI、SATS、RATS、PUPS、TRAC
- **存储/基础设施**：FIL、AR、GRT
- **RWA 和新兴**：ONDO、WLD、PYTH
- **交易所代币**：BNB、CRO、FTT、HYPE
- **Meme 币**：DOGE、SHIB、PEPE、FLOKI、BONK、WIF
- **隐私**：XMR、ZEC
- **其他**：LINK、LTC、BCH、ETC、VET、HBAR、ICP

### 设置自动价格更新

创建每日 cron 作业以自动获取价格：

```bash
# 编辑 crontab
crontab -e

# 添加此行以在上午 9 点每天获取价格
0 9 * * * cd /path/to/finance/crypto && python3 fetch_prices.py >> crypto_prices.beancount
```

### 手动输入价格

您还可以手动将价格添加到 `crypto_prices.beancount`：

```beancount
2025-10-27 price BTC 67500.00 USD
2025-10-27 price ETH 3250.00 USD
2025-10-27 price SOL 175.00 USD
```

### API 速率限制

CoinGecko 免费层有速率限制（约 50 次调用/分钟）。该脚本设计为高效批处理请求，在单个 API 调用中获取所有价格。

## 交易示例

### 在交易所购买加密货币

```beancount
2025-01-15 * "Coinbase" "购买比特币"
  Assets:Crypto:Exchange:Coinbase:BTC     0.5 BTC {50000.00 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD  -25000.00 USD
  Expenses:Crypto:Trading:Fees                   50.00 USD
```

### 转账到冷钱包

```beancount
2025-01-16 * "转账到 Ledger" "将 BTC 转移到硬件钱包"
  Assets:Crypto:Wallet:Ledger:BTC            0.5 BTC
  Assets:Crypto:Exchange:Coinbase:BTC       -0.5 BTC
  Expenses:Crypto:Withdrawal:Fees          0.0001 BTC
```

### 质押奖励

```beancount
2025-01-20 * "质押奖励" "ETH 质押奖励"
  Assets:Crypto:Staking:ETH              0.05 ETH
  Income:Crypto:Staking:Rewards         -0.05 ETH {2500.00 USD}
```

### DeFi 借贷

```beancount
2025-01-25 * "Aave" "存入 USDC 以供借贷"
  Assets:Crypto:DeFi:Aave:USDC              5000 USDC
  Assets:Crypto:Wallet:MetaMask:USDC       -5000 USDC
  Expenses:Crypto:Gas:Ethereum                 15.00 USD
```

### 购买 NFT

```beancount
2025-02-01 * "OpenSea" "购买 Azuki #1234"
  Assets:Crypto:NFT:Ethereum:Azuki         1 AZUKI.1234 {5.5 ETH}
  Assets:Crypto:Wallet:MetaMask:ETH       -5.5 ETH
  Expenses:Crypto:Trading:Fees            0.165 ETH  ; 3% 市场费用
  Expenses:Crypto:Gas:Ethereum            0.005 ETH  ; Gas 费用
```

### 出售 NFT

```beancount
2025-03-15 * "OpenSea" "出售 Doodles #5678"
  Assets:Crypto:Wallet:MetaMask:ETH        8.0 ETH
  Assets:Crypto:NFT:Ethereum:Doodles      -1 DOODLES.5678 {6.0 ETH}
  Expenses:Crypto:Trading:Fees            0.24 ETH   ; 3% 市场费用
  Expenses:Crypto:Gas:Ethereum            0.004 ETH
  Income:Crypto:Trading:CapitalGains     -2.0 ETH    ; NFT 销售收益
```

### 比特币序数

```beancount
2025-04-10 * "Magic Eden" "铭刻 NodeMonkes #42"
  Assets:Crypto:NFT:Bitcoin:NodeMonkes     1 NODEMONKES.42 {0.15 BTC}
  Assets:Crypto:Wallet:Electrum:BTC       -0.15 BTC
  Expenses:Crypto:Trading:Fees            0.003 BTC
```

### BRC-20 代币购买

```beancount
2025-04-20 * "UniSat" "购买 ORDI 代币"
  Assets:Crypto:Exchange:Binance:ORDI      100 ORDI {35.00 USD}
  Assets:Crypto:Exchange:Binance:Cash:USD -3500.00 USD
  Expenses:Crypto:Trading:Fees               10.00 USD
```

## 支持的资产

### Layer-1 区块链

BTC、ETH、SOL、ADA、DOT、AVAX、ATOM、ALGO、XRP、XLM、NEAR、FTM、TON、APT、SUI、LTC、BCH、ETC 等

### Layer-2 解决方案

MATIC、OP、ARB

### 稳定币

USDT、USDC、DAI、BUSD、TUSD

### DeFi 代币

UNI、AAVE、MKR、COMP、SNX、CRV、SUSHI

### 交易所代币

BNB、CRO、FTT

### 永续合约 DEX

HYPE（Hyperliquid）、DYDX（dYdX）、GMX

### Solana DEX

RAY（Raydium）、JUP（Jupiter）、ORCA（Orca）

### 流动性质押和再质押

- **以太坊**：LDO（Lido）、STETH、RPL（Rocket Pool）、RETH、EIGEN（EigenLayer）
- **Solana**：JTO（Jito）、JITOSOL、MNDE（Marinade）、MSOL

### NFT 生态系统代币

APE（ApeCoin）、LOOKS（LooksRare）、X2Y2、SUDO（Sudoswap）、BLUR（Blur）、NFT（APENFT）

### 比特币序数和 BRC-20

ORDI（Ordinals）、SATS、RATS、PUPS（Bitcoin Puppets）、TRAC

### 支持的 NFT 收藏品

- **以太坊**：BAYC、MAYC、Azuki、CloneX、Doodles、Pudgy Penguins、Moonbirds、Cryptopunks、Meebits、Art Blocks、PROOF Collective
- **Solana**：DeGods、y00ts、Mad Lads、Solana Monkey Business、Okay Bears、Tensorians
- **比特币序数**：NodeMonkes、Bitcoin Puppets、Quantum Cats、Ordinal Inscriptions
- **Polygon**：Reddit Collectible Avatars
- **Base**：Based Fellas

### 其他类别

Meme 币（DOGE、SHIB、PEPE、BONK、WIF、FLOKI）、隐私币（XMR、ZEC）、预言机（LINK、PYTH）、AI 代币（FET、AGIX、TAO、RNDR）、游戏和元宇宙（SAND、MANA、AXS、IMX）、存储（FIL、AR）、RWA（ONDO）等

## 自定义指南

Coinbean 的模块化结构使其易于根据您的特定需求进行自定义。本节说明如何添加新的交易所、钱包、协议和加密货币。

### 理解模块化结构

Coinbean 将账户组织到单独的文件中以便更好地维护：

| 文件 | 用途 | 何时编辑 |
|------|---------|--------------|
| `crypto_main.beancount` | 商品定义、核心账户 | 添加新加密货币 |
| `exchanges.beancount` | 中心化交易所账户 | 添加新交易所 |
| `chains.beancount` | 钱包和原生质押 | 添加钱包或质押 |
| `defi.beancount` | DeFi 协议 | 添加 DeFi 协议 |
| `tx_2025.beancount` | 当前年度交易 | 记录您的交易 |

### 添加新交易所

**要编辑的文件：**`exchanges.beancount`

**模板：**
```beancount
;; ========================================
;; 您的交易所名称
;; ========================================

;; 法币账户
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Cash:EUR

;; 加密货币账户
2020-01-01 open Assets:Crypto:Exchange:YourExchange:BTC
2020-01-01 open Assets:Crypto:Exchange:YourExchange:ETH
2020-01-01 open Assets:Crypto:Exchange:YourExchange:SOL
2020-01-01 open Assets:Crypto:Exchange:YourExchange:USDC
2020-01-01 open Assets:Crypto:Exchange:YourExchange:USDT

;; 其他代币的通用账户
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Other
```

**示例 - 添加 Bitfinex：**
```beancount
;; ========================================
;; BITFINEX
;; ========================================

2020-01-01 open Assets:Crypto:Exchange:Bitfinex:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:Bitfinex:BTC
2020-01-01 open Assets:Crypto:Exchange:Bitfinex:ETH
2020-01-01 open Assets:Crypto:Exchange:Bitfinex:USDT
```

**提示：**
- 仅为您实际持有的资产创建账户
- 使用一致的命名（交易所名称使用驼峰命名法）
- 使用注释对相关账户进行分组
- `Other` 账户对于您不想单独跟踪的代币很有用

### 添加新钱包

**要编辑的文件：**`chains.beancount`

**硬件钱包示例：**
```beancount
;; ========================================
;; COLDCARD（比特币硬件钱包）
;; ========================================

2020-01-01 open Assets:Crypto:Wallet:Coldcard:BTC
```

**软件钱包示例：**
```beancount
;; ========================================
;; RABBY WALLET（多链）
;; ========================================

2020-01-01 open Assets:Crypto:Wallet:Rabby:ETH
2020-01-01 open Assets:Crypto:Wallet:Rabby:MATIC
2020-01-01 open Assets:Crypto:Wallet:Rabby:Tokens
```

**移动钱包示例：**
```beancount
;; ========================================
;; COINBASE WALLET（移动应用）
;; ========================================

2020-01-01 open Assets:Crypto:Wallet:CoinbaseWallet:ETH
2020-01-01 open Assets:Crypto:Wallet:CoinbaseWallet:Tokens
```

**账户命名约定：**
```
Assets:Crypto:Wallet:{钱包名称}:{资产}
                     └─────┬─────┘  └──┬──┘
                         钱包名     具体代币/链
```

### 添加原生质押

**要编辑的文件：**`chains.beancount`

**模板：**
```beancount
;; ========================================
;; 质押 - {区块链名称}
;; ========================================

;; 委托/质押资产
2020-01-01 open Assets:Crypto:Staking:CHAIN:Delegated

;; 待处理/解除绑定资产
2020-01-01 open Assets:Crypto:Staking:CHAIN:Unbonding

;; 质押奖励累积
2020-01-01 open Assets:Crypto:Staking:CHAIN:Rewards
```

**示例 - Avalanche 质押：**
```beancount
;; ========================================
;; 质押 - AVALANCHE
;; ========================================

2020-01-01 open Assets:Crypto:Staking:AVAX:Delegated
2020-01-01 open Assets:Crypto:Staking:AVAX:Rewards
```

**示例交易 - 质押 AVAX：**
```beancount
2025-01-15 * "质押 AVAX" "委托给验证者"
  Assets:Crypto:Staking:AVAX:Delegated    100 AVAX
  Assets:Crypto:Wallet:Avalanche:AVAX    -100 AVAX
  Expenses:Crypto:Gas:Avalanche           0.01 AVAX
```

### 添加 DeFi 协议

**要编辑的文件：**`defi.beancount`

**借贷协议示例：**
```beancount
;; ========================================
;; VENUS PROTOCOL（BSC 借贷）
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Venus:BNB
2020-01-01 open Assets:Crypto:DeFi:Venus:USDT
2020-01-01 open Assets:Crypto:DeFi:Venus:Supplied
2020-01-01 open Liabilities:Crypto:DeFi:Venus:Borrowed
```

**DEX 流动性池示例：**
```beancount
;; ========================================
;; ORCA（Solana DEX）
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Orca:SOL
2020-01-01 open Assets:Crypto:DeFi:Orca:USDC
2020-01-01 open Assets:Crypto:DeFi:Orca:LP-Tokens
  name: "Orca LP 代币"
2020-01-01 open Assets:Crypto:DeFi:Orca:ORCA
  name: "ORCA 治理代币"
```

**永续合约 DEX 示例：**
```beancount
;; ========================================
;; VERTEX PROTOCOL（Arbitrum 永续合约）
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Vertex:USDC
2020-01-01 open Assets:Crypto:DeFi:Vertex:Positions
  name: "活跃的永续合约头寸"
2020-01-01 open Assets:Crypto:DeFi:Vertex:VRTX
```

**流动性质押示例：**
```beancount
;; ========================================
;; BENQI（Avalanche 流动性质押）
;; ========================================

2020-01-01 open Assets:Crypto:DeFi:Benqi:SAVAX
  name: "质押的 AVAX（流动性）"
2020-01-01 open Assets:Crypto:DeFi:Benqi:QI
  name: "QI 治理代币"
```

### 添加新加密货币

**要编辑的文件：**`crypto_main.beancount`

**模板：**
```beancount
2020-01-01 commodity TICKER
  name: "全名"
  asset-class: "cryptocurrency"
  blockchain: "区块链名称"
  category: "类别"
  export: "CASH"
```

**Layer-1 区块链示例：**
```beancount
2020-01-01 commodity ALGO
  name: "Algorand"
  asset-class: "cryptocurrency"
  blockchain: "Algorand"
  category: "Layer-1"
  export: "CASH"
```

**DeFi 代币示例：**
```beancount
2020-01-01 commodity CAKE
  name: "PancakeSwap"
  asset-class: "cryptocurrency"
  blockchain: "BNB Chain"
  category: "DeFi"
  export: "CASH"
```

**流动性质押代币示例：**
```beancount
2020-01-01 commodity CBETH
  name: "Coinbase Wrapped Staked ETH"
  asset-class: "cryptocurrency"
  blockchain: "Ethereum"
  category: "Liquid Staking"
  pegged-to: "ETH"
  export: "CASH"
```

**重要规则：**
- ✅ 代码必须全部大写
- ✅ 不能以数字开头（使用 `INCH` 而不是 `1INCH`）
- ✅ 不能包含小写字母或除下划线外的特殊字符
- ✅ 使用描述性类别：Layer-1、Layer-2、DeFi、Stablecoin、NFT、Meme 等

**常见类别：**
- `Layer-1` - 基础区块链（BTC、ETH、SOL）
- `Layer-2` - 扩容解决方案（MATIC、OP、ARB）
- `DeFi` - 去中心化金融（UNI、AAVE、CRV）
- `Liquid Staking` - 质押衍生品（LDO、RPL、JTO）
- `DEX` - 去中心化交易所代币（RAY、JUP）
- `Perpetual DEX` - 永续合约平台（DYDX、GMX、HYPE）
- `Stablecoin` - 与法币挂钩（USDC、USDT、DAI）
- `NFT Marketplace` - NFT 平台（BLUR、LOOKS）
- `BRC-20` - 比特币序数代币（ORDI、SATS）
- `AI` - AI/ML 代币（FET、AGIX、TAO）
- `Gaming` - 游戏代币（AXS、GALA）
- `Meme` - Meme 币（DOGE、SHIB、BONK）

### 添加 NFT 收藏品

**要编辑的文件：**`chains.beancount`（或创建 `nft.beancount`）

**模板：**
```beancount
;; NFT 收藏品 - {区块链}
2020-01-01 open Assets:Crypto:NFT:Blockchain:CollectionName
  name: "完整收藏品名称"
```

**示例：**
```beancount
;; NFT 收藏品 - 以太坊
2020-01-01 open Assets:Crypto:NFT:Ethereum:Pudgy
  name: "Pudgy Penguins"

;; NFT 收藏品 - Solana
2020-01-01 open Assets:Crypto:NFT:Solana:MadLads

;; NFT 收藏品 - 比特币序数
2020-01-01 open Assets:Crypto:NFT:Bitcoin:NodeMonkes
```

### 添加价格获取支持

**要编辑的文件：**`fetch_prices.py`

要为新加密货币添加自动价格获取：

1. 在 https://www.coingecko.com/ 找到 CoinGecko ID
2. 添加到 `fetch_prices.py` 中的 `ASSETS` 列表：

```python
ASSETS = [
    # ... 现有资产 ...
    Asset('YOUR', 'Your Coin Name', 'Ethereum', 'DeFi', 'your-coin-coingecko-id'),
]
```

**示例：**
```python
Asset('CAKE', 'PancakeSwap', 'BNB Chain', 'DEX', 'pancakeswap-token'),
```

**结构：**
- `ticker` - Beancount 中的符号（大写）
- `name` - 资产的全名
- `chain` - 区块链（帮助区分多链资产）
- `category` - 类别（Layer-1、DEX 等）
- `coingecko_id` - CoinGecko API 标识符（来自 URL slug）

### 禁用模块

如果您不使用某些交易所或协议，可以在 `crypto_main.beancount` 中将它们注释掉：

```beancount
;; 中心化交易所
include "exchanges.beancount"

;; 区块链钱包和原生质押
include "chains.beancount"

;; DeFi 协议和流动性质押
; include "defi.beancount"  ; <-- 如果您不使用 DeFi，则注释掉
```

### 验证

进行更改后，始终验证您的账本：

```bash
bean-check crypto_main.beancount
```

如果没有错误，您就可以开始了！如果有错误，输出会准确告诉您哪一行有问题。

## 交易示例

`crypto_examples.beancount` 文件包含 20+ 个综合示例，涵盖：

1. 用法币购买加密货币（市价买入）
2. 出售加密货币换法币
3. 加密货币对加密货币的交易
4. 向交易所存入法币
5. 将加密货币提取到冷钱包
6. 从冷钱包存入加密货币
7. 质押奖励
8. 交易费用
9. Gas 费用（以太坊）
10. DeFi 流动性提供
11. DeFi 收益赚取
12. 空投
13. 购买稳定币
14. 跨交易所转账
15. 定投（DCA）
16. 挖矿奖励
17. DeFi 借款
18. 偿还 DeFi 贷款
19. NFT 购买
20. 交易所代币奖励
21. 将尘埃转换为 BNB

## 税务报告

### 应税事件

1. **资本利得/损失**
   - 出售加密货币换法币
   - 一种加密货币交易另一种
   - 使用加密货币购买商品/服务

2. **收入**
   - 质押奖励
   - 挖矿奖励
   - DeFi 利息/收益
   - 空投
   - 推荐奖金

### 税务目的记录

始终跟踪：
- **成本基础**：原始购买价格 `{价格 USD}`
- **售价**：当前市场价格 `@ 价格 USD`
- **资本利得**：记录在 `Income:Crypto:Trading:CapitalGains`
- **收入**：记录在适当的 `Income:Crypto:*` 账户
- **费用**：在 `Expenses:Crypto:*` 账户中单独跟踪

### 生成税务报告

```bash
# 查看所有资本利得
bean-query crypto_main.beancount "
  SELECT date, account, sum(cost(position)), sum(value(position))
  WHERE account ~ 'CapitalGains'
  GROUP BY date, account
  ORDER BY date
"

# 查看所有质押收入
bean-query crypto_main.beancount "
  SELECT date, account, sum(position)
  WHERE account ~ 'Staking:Rewards'
  ORDER BY date
"
```

## 报告

使用 Beancount 命令生成各种报告：

```bash
# 验证您的账本
bean-check crypto_main.beancount

# 检查账户余额
bean-report crypto_main.beancount balances

# 查看净值
bean-report crypto_main.beancount networth

# 导出到 CSV
bean-report crypto_main.beancount holdings > holdings.csv

# 生成损益表
bean-report crypto_main.beancount income_statement

# 查询特定数据
bean-query crypto_main.beancount "SELECT account, sum(position) WHERE account ~ 'BTC'"

# 在自定义端口上启动 Fava
./run.sh -p 5003
```

## 安全

### 使用 Git 保护您的财务数据

**重要**：如果您使用 Git 对 Beancount 文件进行版本控制，您的交易数据包含敏感的财务信息。**在将文件提交到任何存储库之前，您必须对其进行加密。**

**推荐方法：**

1. **使用 git-crypt**（推荐）或 **git-secret** 加密敏感文件
2. 加密所有包含实际交易数据的 `.beancount` 文件
3. 将加密密钥添加到 `.gitignore` 以防止意外提交

**使用 git-crypt 的示例设置：**

```bash
# 安装 git-crypt
brew install git-crypt  # macOS
# 或：sudo apt-get install git-crypt  # Linux

# 在您的存储库中初始化 git-crypt
cd /path/to/coinbean
git-crypt init

# 在 .gitattributes 中指定要加密的文件
echo "*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
echo "tx_*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes

# 添加协作者（可选）
git-crypt add-gpg-user YOUR_GPG_KEY_ID
```

**要加密的内容：**
- ✅ 所有交易文件（`tx_*.beancount`）
- ✅ 具有真实余额的账户文件（`exchanges.beancount`、`chains.beancount`、`defi.beancount`）
- ✅ 包含您实际头寸的价格文件
- ❌ 模板/示例文件可以保持未加密

**其他安全措施：**
- 为敏感数据与模板使用单独的分支
- 切勿将未加密的财务数据推送到公共存储库
- 在推送前查看所有提交以确保没有暴露敏感数据
- 即使加密，也要考虑使用私有存储库

## 最佳实践

1. **及时记录交易**：在交易发生时记录 - 不要让它们堆积
2. **跟踪每笔费用**：提款、交易和 Gas 费用都是可抵扣的税务支出
3. **定期更新价格**：每周最少，活跃交易者每天更新
4. **备份您的数据**：定期提交到 git 并保留交易所导出文件
5. **定期对账**：每月与交易所余额进行比较
6. **记录复杂交易**：为不寻常的交易和 DeFi 头寸添加注释
7. **分离热钱包和冷钱包**：使用不同的账户并跟踪转账费用
8. **为税务做计划**：准确记录成本基础并咨询税务专业人士
9. **使用一致的账户**：坚持命名约定并保持组织有序
10. **隐私**：切勿将包含真实交易数据的文件提交到公共存储库

## 故障排除

### 常见问题

**"bean-check 报告错误"**
- 检查账户名称中的拼写错误
- 确保所有交易平衡
- 验证商品符号匹配

**"Fava 中未显示价格"**
- 更新 `crypto_prices.beancount`
- 确保日期格式为 YYYY-MM-DD
- 检查商品符号完全匹配

**"余额与交易所不匹配"**
- 按时间顺序查看所有交易
- 检查遗漏的费用
- 验证转账金额

**"Fava 无法启动"**
- 确保 Fava 已安装：`pip3 install fava`
- 检查端口是否未被使用：尝试 `./run.sh -p 5003`
- 验证账本：`bean-check crypto_main.beancount`

### 获取帮助

- **Beancount 文档**：https://beancount.github.io/docs/
- **Fava 文档**：https://beancount.github.io/fava/
- **Beancount 邮件列表**：https://groups.google.com/forum/#!forum/beancount
- **Fava GitHub**：https://github.com/beancount/fava

## 高级主题

### 使用 bean-query 自定义查询

使用 `bean-query` 创建自定义报告：

```bash
# 总投资组合价值
bean-query crypto_main.beancount "
  SELECT sum(convert(value(position), 'USD')) AS total_value
  WHERE account ~ 'Assets:Crypto'
"

# 按价值排名前 5 的持仓
bean-query crypto_main.beancount "
  SELECT account, sum(convert(value(position), 'USD')) AS value
  WHERE account ~ 'Assets:Crypto'
  GROUP BY account
  ORDER BY value DESC
  LIMIT 5
"

# 每月质押收入
bean-query crypto_main.beancount "
  SELECT year(date), month(date), sum(position)
  WHERE account = 'Income:Crypto:Staking:Rewards'
  GROUP BY year(date), month(date)
  ORDER BY year(date), month(date)
"
```

### 扩展价格获取器

`fetch_prices.py` 脚本可以轻松扩展。要添加新的加密货币：

1. 在 https://www.coingecko.com/ 找到 CoinGecko ID
2. 将其添加到 `fetch_prices.py` 中的 `ASSETS` 列表，并包含链和类别信息
3. 将商品定义添加到 `crypto_main.beancount`

示例：
```python
# 在 fetch_prices.py 中 - 添加到 ASSETS 列表
ASSETS = [
    # ... 现有资产 ...
    Asset('NEW', 'New Coin Name', 'Ethereum', 'DeFi', 'new-coin-coingecko-id'),
]
```

Asset 结构包括：
- `ticker`：Beancount 中使用的符号（大写）
- `name`：资产的全名
- `chain`：区块链/网络（帮助区分不同链上的相同代码）
- `category`：类型（Layer-1、DEX、流动性质押等）
- `coingecko_id`：CoinGecko API 标识符

## 资源

访问 [coinbean.org/docs](http://coinbean.org/docs) 了解更多关于：
- 高级交易模式
- 税务报告策略
- 与其他工具集成
- 社区最佳实践

**项目链接：**
- 📦 [GitHub 存储库](https://github.com/qai-lab/coinbean) - 源代码、问题和贡献
- 📋 [发布说明](https://github.com/qai-lab/coinbean/releases) - 版本历史和更新日志
- 🌐 [Coinbean 网站](https://coinbean.org/) - 官方网站和文档
- 🐦 [Coinbean X/Twitter](https://x.com/coinbean_org) - 关注获取更新和新闻
- 📚 [Beancount 文档](https://beancount.github.io/docs/) - 了解 Beancount
- 🖥️ [Fava - Web 界面](https://github.com/beancount/fava) - Beancount Web 界面
- 💬 [纯文本记账](https://plaintextaccounting.org/) - 社区和资源

## 贡献

欢迎贡献！请随时提交 Pull Request。贡献领域：

- 额外的交易所模板
- 更多 DeFi 协议
- 导入交易的自动化脚本
- 文档改进

## 作者

**Coinbean** 由以下人员创建和维护：

- **Boyuan Qian**
  - 🐙 GitHub: [@boyuanqian](https://github.com/boyuanqian)
  - 🐦 X/Twitter: [@boyuan_qian](https://x.com/boyuan_qian)
  - 🏢 组织：[QAI Lab](https://github.com/qai-lab)

**QAI Lab**
  - 🐙 GitHub: [@qai-lab](https://github.com/qai-lab)
  - 🐦 X/Twitter: [@qai_lab](https://x.com/qai_lab)

## 许可证

MIT 许可证 - 版权所有 (c) 2025 Boyuan Qian 和 QAI Lab

详情请参阅 [LICENSE](LICENSE) 文件。

此模板按原样提供供个人使用。根据您的投资组合跟踪需求进行自定义。

## 免责声明

这是一个个人财务跟踪工具。它不提供：
- 财务建议
- 税务建议
- 投资建议

对于财务和税务事宜，请始终咨询合格的专业人士。加密货币投资有风险，可能导致资本损失。

---

**祝跟踪愉快！ 📊💰**
