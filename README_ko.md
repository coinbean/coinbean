<div align="center">
  <img src="images/banner.png" alt="Coinbean 배너" width="100%">
</div>

<div align="center">

Coinbean AI - 복식 부기를 활용한 종합 암호화폐 포트폴리오 추적 시스템

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/CoinbeanAI](https://x.com/CoinbeanAI)

[English](README.md) | [简体中文](README_zh.md) | [Français](README_fr.md) | 한국어 | [日本語](README_ja.md) | [Español](README_es.md)

---

**제작: [Boyuan Qian](https://github.com/boyuanqian) @[QAI Lab](https://github.com/qai-lab)**

</div>

## 🎥 데모 영상

[![Coinbean 데모](https://img.youtube.com/vi/2TaJvP5Ysfc/maxresdefault.jpg)](https://youtu.be/2TaJvP5Ysfc)

## ⚡ 빠른 시작

### 옵션 1: Docker (권장)

```bash
./run.sh  # Docker용 옵션 1 선택
# 또는: docker-compose up -d
```

### 옵션 2: 네이티브 설치

```bash
./setup.sh              # 종속성 설치
./run.sh                # Fava 웹 인터페이스 시작
./prices.sh             # 현재 가격 가져오기
```

브라우저에서 http://localhost:5002 를 열어 포트폴리오를 확인하세요.

## Coinbean이란?

복식 부기를 사용하여 거래소, 지갑, DeFi, 스테이킹 및 NFT에서 암호화폐 포트폴리오를 추적합니다.

**지원:**

- 10+ 개 거래소 (Coinbase, Binance, Kraken 등)
- 하드웨어/소프트웨어 지갑 (Ledger, MetaMask, Phantom)
- DeFi 프로토콜 (Aave, Uniswap, Lido, Hyperliquid)
- 스테이킹 & 이자 농사
- NFT (Ethereum, Solana, Bitcoin Ordinals)
- 110+ 개 암호화폐

## 기능

- ✅ 거래소, 지갑, DeFi를 위한 사전 구성된 계정
- ✅ 자동 가격 가져오기를 지원하는 110+ 개 암호화폐
- ✅ NFT 및 Bitcoin Ordinals 추적
- ✅ 자본 이득 추적을 통한 세금 보고
- ✅ 아름다운 웹 인터페이스 (Fava)
- ✅ 쉬운 배포를 위한 Docker 지원

## 파일 구조

```
coinbean/
├── crypto_main.beancount       # 메인 원장 (110+ 개 암호화폐 정의)
├── exchanges.beancount         # 거래소 계정
├── chains.beancount            # 지갑 & 스테이킹
├── defi.beancount              # DeFi 프로토콜
├── crypto_prices.beancount     # 가격 데이터
├── tx_2025.beancount           # 귀하의 거래
├── crypto_examples.beancount   # 20+ 개 예제 거래
├── setup.sh / run.sh / prices.sh
└── docker-compose.yml
```

**이 파일들을 편집하세요:**

- `tx_2025.beancount` - 거래 추가
- `exchanges.beancount` - 사용하는 거래소만 활성화
- `chains.beancount` - 지갑 추가
- `defi.beancount` - 사용하는 DeFi 프로토콜 추가

## 계정 구조

```
Assets:Crypto
├── Exchange:{거래소}:{자산}         # Coinbase:BTC, Binance:ETH
├── Wallet:{지갑}:{자산}             # Ledger:BTC, MetaMask:ETH
├── Staking:{체인}:{상태}            # ETH:Delegated, SOL:Rewards
├── DeFi:{프로토콜}:{자산}           # Aave:USDC, Uniswap:LPTokens
└── NFT:{체인}:{컬렉션}              # Ethereum:BAYC, Solana:DeGods

Income:Crypto
├── Staking:Rewards
├── Trading:CapitalGains
└── Airdrops

Expenses:Crypto
├── Trading:Fees
├── Gas:{체인}                      # Ethereum, Solana 등
└── Withdrawal:Fees
```

## 거래 기록

20+ 개의 예제는 `crypto_examples.beancount`를 참조하세요. 기본 형식:

```beancount
2025-01-15 * "Coinbase" "비트코인 구매"
  Assets:Crypto:Exchange:Coinbase:BTC      0.1 BTC {60000 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD -6000.00 USD
  Expenses:Crypto:Trading:Fees             10.00 USD
```

## 사용자 지정

### 새 거래소 추가

`exchanges.beancount` 편집:

```beancount
2020-01-01 open Assets:Crypto:Exchange:YourExchange:Cash:USD
2020-01-01 open Assets:Crypto:Exchange:YourExchange:BTC
2020-01-01 open Assets:Crypto:Exchange:YourExchange:ETH
```

### 새 암호화폐 추가

`crypto_main.beancount` 편집:

```beancount
2020-01-01 commodity YOUR
  name: "귀하의 코인"
  blockchain: "Ethereum"
  category: "DeFi"
```

그런 다음 `fetch_prices.py`에 추가:

```python
Asset('YOUR', 'Your Coin', 'Ethereum', 'DeFi', 'your-coin-id'),
```

### 사용하지 않는 모듈 비활성화

`crypto_main.beancount`에서 주석 처리:

```beancount
include "exchanges.beancount"
include "chains.beancount"
; include "defi.beancount"  # DeFi 사용 안 함
```

## 명령어

| 명령어                                         | 목적                        |
| ---------------------------------------------- | --------------------------- |
| `./run.sh`                                     | Fava 시작 (대화형 메뉴)     |
| `./prices.sh`                                  | 현재 암호화폐 가격 가져오기 |
| `bean-check crypto_main.beancount`             | 원장 검증                   |
| `bean-query crypto_main.beancount "SELECT..."` | 데이터 쿼리                 |
| `docker-compose up -d`                         | Docker로 시작               |
| `docker-compose logs -f`                       | Docker 로그 보기            |

## 세금 보고

**자동으로 추적되는 과세 대상 이벤트:**

- 자본 이득/손실 (암호화폐 판매, 스왑)
- 스테이킹 보상 (소득)
- 에어드롭 (소득)
- DeFi 수익 (소득)

**보고서 생성:**

```bash
# 모든 자본 이득 보기
bean-query crypto_main.beancount "
  SELECT date, account, sum(position)
  WHERE account ~ 'CapitalGains'
  ORDER BY date"

# 스테이킹 수입 보기
bean-query crypto_main.beancount "
  SELECT date, sum(position)
  WHERE account ~ 'Staking:Rewards'"
```

## 보안

⚠️ **중요:** 암호화되지 않은 재무 데이터를 공개 저장소에 커밋하지 마세요.

**git-crypt를 사용하여 민감한 파일 암호화:**

```bash
brew install git-crypt
git-crypt init
echo "*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
echo "tx_*.beancount filter=git-crypt diff=git-crypt" >> .gitattributes
```

## 문제 해결

| 문제                 | 해결책                                                |
| -------------------- | ----------------------------------------------------- |
| `bean-check` 오류    | 계정 이름 확인, 거래가 균형을 이루는지 확인           |
| 가격이 표시되지 않음 | `./prices.sh` 실행, `crypto_prices.beancount` 확인    |
| 잔액 불일치          | 모든 거래 검토, 누락된 수수료 확인                    |
| Fava가 시작되지 않음 | 포트 5002가 사용 중인지 확인, `./run.sh -p 5003` 시도 |
| Docker 문제          | `docker-compose logs`로 로그 확인                     |

## 리소스

- 📦 [GitHub 저장소](https://github.com/coinbean/coinbean)
- 📋 [릴리스 노트](https://github.com/coinbean/coinbean/releases)
- 🌐 [Coinbean 웹사이트](https://coinbean.org/)
- 🐦 [X/Twitter 팔로우](https://x.com/CoinbeanAI)
- 📚 [Beancount 문서](https://beancount.github.io/docs/)
- 🖥️ [Fava 문서](https://github.com/beancount/fava)

## 저자

**제작자:**

- **Boyuan Qian** - [@boyuanqian](https://github.com/boyuanqian) | [@boyuan_qian](https://x.com/boyuan_qian)

**조직:**

- **QAI Lab** - [qai.io](https://qai.io) | [@qai-lab](https://github.com/qai-lab) | [@qai_lab](https://x.com/qai_lab)

## 라이선스

MIT 라이선스 - Copyright (c) 2025 Boyuan Qian 및 QAI Lab. [LICENSE](LICENSE) 파일 참조.

## 면책 조항

이 도구는 개인 포트폴리오 추적 전용입니다. 재무, 세금 또는 투자 조언을 제공하지 않습니다. 암호화폐 투자는 위험을 수반합니다. 재무 및 세금 문제에 대해서는 자격을 갖춘 전문가와 상담하십시오.

---

**즐거운 추적되시길! 📊**
