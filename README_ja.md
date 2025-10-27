<div align="center">
  <img src="images/banner.png" alt="Coinbeanバナー" width="100%">
</div>

<div align="center">

[Beancount](https://github.com/beancount/beancount)複式簿記システムを基盤とした包括的な暗号通貨ポートフォリオ追跡システム

**制作: [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)**

[English](README.md) | [简体中文](README_zh.md) | [Français](README_fr.md) | [한국어](README_ko.md) | 日本語 | [Español](README_es.md)

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/coinbean_org](https://x.com/coinbean_org)

</div>

## 🎥 デモ動画

[![Coinbeanデモ](https://img.youtube.com/vi/2TaJvP5Ysfc/maxresdefault.jpg)](https://youtu.be/2TaJvP5Ysfc)

## ⚡ クイックスタート

### オプション1: Docker（推奨）

```bash
./run.sh  # Docker用のオプション1を選択
# または: docker-compose up -d
```

### オプション2: ネイティブインストール

```bash
./setup.sh              # 依存関係をインストール
./run.sh                # Fava Webインターフェースを起動
./prices.sh             # 現在の価格を取得
```

ブラウザで http://localhost:5002 を開いてポートフォリオを表示してください。

## Coinbeanとは？

Coinbeanは、以下の暗号通貨ポートフォリオを追跡するための構造化されたBeancountレジャーテンプレートです：

- 複数の中央集権型取引所（Coinbase、Binance、Krakenなど）
- ハードウェアおよびソフトウェアウォレット（Ledger、Trezor、MetaMask、Phantom）
- DeFiプロトコル（Aave、Compound、Uniswap、Raydium、Jupiterなど）
- パーペチュアルDEX（Hyperliquid、dYdX、GMX）
- リキッドステーキングプロトコル（Lido、Rocket Pool、Jito、Marinade）
- リステーキングプロトコル（EigenLayer、Solayer）
- NFTコレクション（BAYC、Azuki、DeGods、Bitcoin Ordinalsなど）
- ステーキングとイールドファーミング活動
- Layer-1、Layer-2、DeFi、ステーブルコイン、NFTなど、110以上の暗号通貨

## 機能

- **包括的な資産カバレッジ**: BTC、ETH、SOLなど110以上の暗号通貨およびNFTコレクションを事前設定でサポート
- **マルチ取引所サポート**: 10以上の主要取引所で資産を追跡（Coinbase、Binance、Kraken、Gemini、Crypto.comなど）
- **DeFi統合**: レンディング、流動性プール、ステーキングの会計処理
- **NFT追跡**: Ethereum、Solana、Bitcoin Ordinals、Polygon、Baseの人気NFTコレクションをサポート
- **Bitcoin Ordinals & BRC-20**: OrdinalsインスクリプションおよびBRC-20トークン（ORDI、SATSなど）を追跡
- **精密な小数点処理**: サトシ、gweiおよびその他の小単位に対する許容誤差を設定
- **複式簿記**: 適切な会計原則による完全な監査証跡
- **税務申告準備**: 様々なソースからのキャピタルゲイン、手数料、収入を追跡
- **Webインターフェース**: Favaによる美しい視覚化
- **簡単なセットアップ**: 自動化されたセットアップおよび実行スクリプトを含む

## ⚡ クイックリファレンス

| スクリプト       | コマンド      | 目的                                         |
| ---------------- | ------------- | -------------------------------------------- |
| **セットアップ** | `./setup.sh`  | Beancount & Favaのインストール、レジャー検証 |
| **Fava起動**     | `./run.sh`    | http://localhost:5002でWebインターフェース起動 |
| **価格取得**     | `./prices.sh` | 現在の暗号通貨価格を取得（対話型メニュー）    |

詳細なドキュメントについては、[ヘルパースクリプト](#ヘルパースクリプト)セクションを参照してください。

## ファイル構造

Coinbeanはより良い組織のために**モジュラー構造**を使用します：

```
crypto/
├── crypto_main.beancount       # コモディティとインポートを含むメインレジャー
├── exchanges.beancount         # 中央集権型取引所アカウント
├── chains.beancount            # ブロックチェーンウォレットとネイティブステーキング
├── defi.beancount              # DeFiプロトコル、リキッドステーキング、リステーキング
├── crypto_prices.beancount     # すべての資産の価格データ
├── tx_2024.beancount           # 2024年の取引
├── tx_2025.beancount           # 2025年の取引
├── crypto_examples.beancount   # 20以上の取引例（参照）
├── fetch_prices.py             # CoinGeckoからの自動価格取得
├── prices.sh                   # fetch_prices.pyの便利なラッパー
├── setup.sh                    # 自動セットアップおよびインストールスクリプト
├── run.sh                      # Fava Webインターフェース起動
└── README.md                   # このファイル
```

## アカウント構造

Coinbeanは階層的なアカウント構造を持つBeancountの**複式簿記**原則に従います：

```
Assets:Crypto
├── Exchange                    # 中央集権型取引所
│   ├── Coinbase
│   │   ├── Cash:USD           # 法定通貨残高
│   │   ├── BTC                # Bitcoin残高
│   │   ├── ETH                # Ethereum残高
│   │   └── Other              # その他のトークン
│   ├── Binance
│   ├── Kraken
│   └── [10以上の取引所...]
│
├── Wallet                      # 自己管理ウォレット
│   ├── Ledger                 # ハードウェアウォレット
│   │   ├── BTC
│   │   └── ETH
│   ├── MetaMask               # ソフトウェアウォレット
│   ├── Phantom
│   └── [その他のウォレット...]
│
├── Staking                     # ネイティブブロックチェーンステーキング
│   ├── ETH
│   │   ├── Delegated          # ステーキング額
│   │   └── Rewards            # 獲得報酬
│   ├── SOL
│   ├── ADA
│   └── [その他のチェーン...]
│
├── DeFi                        # DeFiプロトコル
│   ├── Aave                   # レンディング
│   │   ├── USDC
│   │   └── ETH
│   ├── Uniswap                # DEX
│   │   └── LPTokens
│   ├── Hyperliquid            # パーペチュアルDEX
│   ├── Lido                   # リキッドステーキング
│   │   └── STETH
│   └── [その他のプロトコル...]
│
└── NFT                         # NFTコレクション
    ├── Ethereum
    │   ├── BAYC
    │   ├── Azuki
    │   └── [その他のコレクション...]
    ├── Solana
    │   ├── DeGods
    │   └── MadLads
    └── Bitcoin
        └── NodeMonkes

Liabilities:Crypto
└── DeFi                        # DeFi借入
    ├── Aave:Borrowed
    └── Compound:Borrowed

Income:Crypto
├── Staking:Rewards             # ステーキング収入
├── Mining:Rewards              # マイニング収入
├── Airdrops                    # エアドロップトークン
├── Referrals                   # 紹介ボーナス
└── Trading:CapitalGains        # 実現利益

Expenses:Crypto
├── Trading:Fees                # 取引所手数料
├── Withdrawal:Fees             # 出金手数料
├── Gas                         # 取引手数料
│   ├── Ethereum
│   ├── Solana
│   └── [その他のチェーン...]
└── Trading:Losses              # 実現損失

Equity:Opening-Balances         # 初期残高
```

### アカウント命名規則

Coinbeanは一貫した階層的命名構造を使用します：

```
Assets:Crypto:{タイプ}:{プラットフォーム}:{資産}
             └──┬──┘ └────┬────┘ └──┬──┘
              タイプ   プラットフォーム  特定の
                                    トークン
```

**例:**

- `Assets:Crypto:Exchange:Coinbase:BTC` - CoinbaseのBitcoin
- `Assets:Crypto:Wallet:Ledger:ETH` - LedgerのEthereum
- `Assets:Crypto:DeFi:Aave:USDC` - Aaveに預けられたUSDC
- `Assets:Crypto:Staking:SOL:Delegated` - ステーキングされたSolana
- `Assets:Crypto:NFT:Ethereum:BAYC` - Bored Ape Yacht Club NFT

**ヒント:**

- プラットフォーム名にはCamelCaseを使用（例：`MetaMask`、`metamask`ではない）
- 資産ティッカーは大文字で維持（例：`BTC`、`ETH`）
- すべての取引で一貫性を保つ

## 取引例

### 取引所で暗号通貨を購入

```beancount
2025-01-15 * "Coinbase" "Bitcoin購入"
  Assets:Crypto:Exchange:Coinbase:BTC     0.5 BTC {50000.00 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD  -25000.00 USD
  Expenses:Crypto:Trading:Fees                   50.00 USD
```

### コールドストレージへ転送

```beancount
2025-01-16 * "Ledgerへ転送" "ハードウェアウォレットへBTC移動"
  Assets:Crypto:Wallet:Ledger:BTC            0.5 BTC
  Assets:Crypto:Exchange:Coinbase:BTC       -0.5 BTC
  Expenses:Crypto:Withdrawal:Fees          0.0001 BTC
```

### ステーキング報酬

```beancount
2025-01-20 * "ステーキング報酬" "ETHステーキング報酬"
  Assets:Crypto:Staking:ETH              0.05 ETH
  Income:Crypto:Staking:Rewards         -0.05 ETH {2500.00 USD}
```

### DeFiレンディング

```beancount
2025-01-25 * "Aave" "レンディング用USDC預金"
  Assets:Crypto:DeFi:Aave:USDC              5000 USDC
  Assets:Crypto:Wallet:MetaMask:USDC       -5000 USDC
  Expenses:Crypto:Gas:Ethereum                 15.00 USD
```

## サポートされている資産

### Layer-1ブロックチェーン

BTC、ETH、SOL、ADA、DOT、AVAX、ATOM、ALGO、XRP、XLM、NEAR、FTM、TON、APT、SUI、LTC、BCH、ETCなど

### Layer-2ソリューション

MATIC、OP、ARB

### ステーブルコイン

USDT、USDC、DAI、BUSD、TUSD

### DeFiトークン

UNI、AAVE、MKR、COMP、SNX、CRV、SUSHI

### 取引所トークン

BNB、CRO、FTT

### パーペチュアルDEX

HYPE（Hyperliquid）、DYDX（dYdX）、GMX

### Solana DEX

RAY（Raydium）、JUP（Jupiter）、ORCA（Orca）

### リキッドステーキング & リステーキング

- **Ethereum**: LDO（Lido）、STETH、RPL（Rocket Pool）、RETH、EIGEN（EigenLayer）
- **Solana**: JTO（Jito）、JITOSOL、MNDE（Marinade）、MSOL

### NFTエコシステムトークン

APE（ApeCoin）、LOOKS（LooksRare）、X2Y2、SUDO（Sudoswap）、BLUR（Blur）、NFT（APENFT）

### Bitcoin Ordinals & BRC-20

ORDI（Ordinals）、SATS、RATS、PUPS（Bitcoin Puppets）、TRAC

### サポートされているNFTコレクション

- **Ethereum**: BAYC、MAYC、Azuki、CloneX、Doodles、Pudgy Penguins、Moonbirds、Cryptopunks、Meebits、Art Blocks、PROOF Collective
- **Solana**: DeGods、y00ts、Mad Lads、Solana Monkey Business、Okay Bears、Tensorians
- **Bitcoin Ordinals**: NodeMonkes、Bitcoin Puppets、Quantum Cats、Ordinal Inscriptions
- **Polygon**: Reddit Collectible Avatars
- **Base**: Based Fellas

## リソース

詳細については[coinbean.org/docs](http://coinbean.org/docs)をご覧ください：

- 高度な取引パターン
- 税務申告戦略
- 他のツールとの統合
- コミュニティのベストプラクティス

**プロジェクトリンク:**

- 📦 [GitHubリポジトリ](https://github.com/qai-lab/coinbean) - ソースコード、問題、貢献
- 📋 [リリースノート](https://github.com/qai-lab/coinbean/releases) - バージョン履歴と変更履歴
- 🌐 [Coinbean Webサイト](https://coinbean.org/) - 公式Webサイトとドキュメント
- 🐦 [Coinbean X/Twitter](https://x.com/coinbean_org) - 最新情報とニュースをフォロー
- 📚 [Beancountドキュメント](https://beancount.github.io/docs/) - Beancountを学ぶ
- 🖥️ [Fava - Webインターフェース](https://github.com/beancount/fava) - Beancount Webインターフェース
- 💬 [Plain Text Accounting](https://plaintextaccounting.org/) - コミュニティとリソース

## 貢献

貢献を歓迎します！プルリクエストをお気軽に送信してください。貢献の分野：

- 追加の取引所テンプレート
- より多くのDeFiプロトコル
- 取引をインポートするための自動化スクリプト
- ドキュメントの改善

## 著者

**Coinbean**は以下により作成および維持されています：

- **Boyuan Qian**
  - 🐙 GitHub: [@boyuanqian](https://github.com/boyuanqian)
  - 🐦 X/Twitter: [@boyuan_qian](https://x.com/boyuan_qian)
  - 🏢 組織: [QAI Lab](https://github.com/qai-lab)

**QAI Lab**

- 🌐 Webサイト: [qai.io](https://qai.io)
- 🐙 GitHub: [@qai-lab](https://github.com/qai-lab)
- 🐦 X/Twitter: [@qai_lab](https://x.com/qai_lab)

## ライセンス

MITライセンス - Copyright (c) 2025 Boyuan QianおよびQAI Lab

詳細については[LICENSE](LICENSE)ファイルを参照してください。

このテンプレートは個人使用のためにそのまま提供されます。ポートフォリオ追跡のニーズに合わせてカスタマイズしてください。

## 免責事項

これは個人の財務追跡ツールです。以下を提供しません：

- 財務アドバイス
- 税務アドバイス
- 投資推奨

財務および税務の問題については、必ず資格のある専門家に相談してください。暗号通貨への投資はリスクがあり、資本の損失をもたらす可能性があります。

---

**楽しく追跡しましょう！📊💰**
