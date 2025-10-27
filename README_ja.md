<div align="center">
  <img src="images/banner.png" alt="Coinbeanバナー" width="100%">
</div>

<div align="center">

[Beancount](https://github.com/beancount/beancount)複式簿記システムを基盤とした包括的な暗号通貨ポートフォリオ追跡システム

**制作: [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)**

[English](README.md) | [简体中文](README_zh.md) | [Français](README_fr.md) | [한국어](README_ko.md) | 日本語 | [Español](README_es.md)

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/CoinbeanAI](https://x.com/CoinbeanAI)

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

複式簿記を使用して、取引所、ウォレット、DeFi、ステーキング、NFTにわたる暗号通貨ポートフォリオを追跡します。

**サポート:**
- 10以上の取引所（Coinbase、Binance、Krakenなど）
- ハードウェア/ソフトウェアウォレット（Ledger、MetaMask、Phantom）
- DeFiプロトコル（Aave、Uniswap、Lido、Hyperliquid）
- ステーキング＆イールドファーミング
- NFT（Ethereum、Solana、Bitcoin Ordinals）
- 110以上の暗号通貨

## 機能

- ✅ 取引所、ウォレット、DeFi用の事前設定アカウント
- ✅ 自動価格取得をサポートする110以上の暗号通貨
- ✅ NFTとBitcoin Ordinalsの追跡
- ✅ キャピタルゲイン追跡による税務申告
- ✅ 美しいWebインターフェース（Fava）
- ✅ 簡単なデプロイのためのDockerサポート

## ファイル構造

```
coinbean/
├── crypto_main.beancount       # メインレジャー（110以上の暗号通貨定義）
├── exchanges.beancount         # 取引所アカウント
├── chains.beancount            # ウォレット＆ステーキング
├── defi.beancount              # DeFiプロトコル
├── crypto_prices.beancount     # 価格データ
├── tx_2025.beancount           # あなたの取引
├── crypto_examples.beancount   # 20以上の取引例
├── setup.sh / run.sh / prices.sh
└── docker-compose.yml
```

**これらのファイルを編集:**
- `tx_2025.beancount` - 取引を追加
- `exchanges.beancount` - 使用する取引所のみを有効化
- `chains.beancount` - ウォレットを追加
- `defi.beancount` - 使用するDeFiプロトコルを追加

## アカウント構造

```
Assets:Crypto
├── Exchange:{取引所}:{資産}           # Coinbase:BTC, Binance:ETH
├── Wallet:{ウォレット}:{資産}         # Ledger:BTC, MetaMask:ETH
├── Staking:{チェーン}:{ステータス}    # ETH:Delegated, SOL:Rewards
├── DeFi:{プロトコル}:{資産}           # Aave:USDC, Uniswap:LPTokens
└── NFT:{チェーン}:{コレクション}      # Ethereum:BAYC, Solana:DeGods

Income:Crypto
├── Staking:Rewards
├── Trading:CapitalGains
└── Airdrops

Expenses:Crypto
├── Trading:Fees
├── Gas:{チェーン}                     # Ethereum, Solanaなど
└── Withdrawal:Fees
```

## 取引の記録

20以上の例については `crypto_examples.beancount` を参照してください。基本形式:

```beancount
2025-01-15 * "Coinbase" "ビットコイン購入"
  Assets:Crypto:Exchange:Coinbase:BTC      0.1 BTC {60000 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD -6000.00 USD
  Expenses:Crypto:Trading:Fees             10.00 USD
```

## カスタマイズ

### 新しい取引所を追加

`exchanges.beancount` を編集:

```beancount
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:YourExchange:BTC
2020-01-01 open Assets:Crypto:Exchange:YourExchange:ETH
```

### 新しい暗号通貨を追加

`crypto_main.beancount` を編集:

```beancount
2020-01-01 commodity YOUR
  name: "あなたのコイン"
  blockchain: "Ethereum"
  category: "DeFi"
```

次に `fetch_prices.py` に追加:

```python
Asset('YOUR', 'Your Coin', 'Ethereum', 'DeFi', 'your-coin-id'),
```

### 未使用モジュールを無効化

`crypto_main.beancount` でコメントアウト:

```beancount
include "exchanges.beancount"
include "chains.beancount"
; include "defi.beancount"  # DeFiを使用しない
```

## コマンド

| コマンド | 目的 |
|----------|------|
| `./run.sh` | Favaを起動（対話型メニュー）|
| `./prices.sh` | 現在の暗号通貨価格を取得 |
| `bean-check crypto_main.beancount` | レジャーを検証 |
| `bean-query crypto_main.beancount "SELECT..."` | データをクエリ |
| `docker-compose up -d` | Dockerで起動 |
| `docker-compose logs -f` | Dockerログを表示 |

## 税務申告

**自動的に追跡される課税イベント:**
- キャピタルゲイン/ロス（暗号通貨の売却、スワップ）
- ステーキング報酬（収入として）
- エアドロップ（収入として）
- DeFi利回り（収入として）

**レポートの生成:**

```bash
# すべてのキャピタルゲインを表示
bean-query crypto_main.beancount "
  SELECT date, account, sum(position)
  WHERE account ~ 'CapitalGains'
  ORDER BY date"

# ステーキング収入を表示
bean-query crypto_main.beancount "
  SELECT date, sum(position)
  WHERE account ~ 'Staking:Rewards'"
```

## セキュリティ

⚠️ **重要:** 暗号化されていない財務データを公開リポジトリにコミットしないでください。

**git-cryptを使用して機密ファイルを暗号化:**

```bash
brew install git-crypt
git-crypt init
echo "*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
echo "tx_*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
```

## トラブルシューティング

| 問題 | 解決策 |
|------|--------|
| `bean-check` エラー | アカウント名を確認、取引がバランスしているか確認 |
| 価格が表示されない | `./prices.sh` を実行、`crypto_prices.beancount` を確認 |
| 残高の不一致 | すべての取引を確認、不足している手数料を確認 |
| Favaが起動しない | ポート5002が使用中か確認、`./run.sh -p 5003` を試す |
| Docker の問題 | `docker-compose logs` でログを確認 |

## リソース

- 📦 [GitHubリポジトリ](https://github.com/qai-lab/coinbean)
- 📋 [リリースノート](https://github.com/qai-lab/coinbean/releases)
- 🌐 [Coinbean ウェブサイト](https://coinbean.org/)
- 🐦 [X/Twitterでフォロー](https://x.com/CoinbeanAI)
- 📚 [Beancount ドキュメント](https://beancount.github.io/docs/)
- 🖥️ [Fava ドキュメント](https://github.com/beancount/fava)

## 著者

**制作者:**
- **Boyuan Qian** - [@boyuanqian](https://github.com/boyuanqian) | [@boyuan_qian](https://x.com/boyuan_qian)

**組織:**
- **QAI Lab** - [qai.io](https://qai.io) | [@qai-lab](https://github.com/qai-lab) | [@qai_lab](https://x.com/qai_lab)

## ライセンス

MITライセンス - Copyright (c) 2025 Boyuan Qian および QAI Lab。[LICENSE](LICENSE)ファイルを参照。

## 免責事項

このツールは個人のポートフォリオ追跡専用です。財務、税務、または投資アドバイスを提供するものではありません。暗号通貨投資にはリスクが伴います。財務および税務に関する事項については、資格のある専門家に相談してください。

---

**楽しく追跡してください！ 📊**
