<div align="center">
  <img src="images/banner.png" alt="Coinbean 배너" width="100%">
</div>

<div align="center">

[Beancount](https://github.com/beancount/beancount) 복식 부기 시스템을 기반으로 한 종합 암호화폐 포트폴리오 추적 시스템

**제작: [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)**

[English](README.md) | [简体中文](README_zh.md) | [Français](README_fr.md) | 한국어 | [日本語](README_ja.md) | [Español](README_es.md)

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/coinbean_org](https://x.com/coinbean_org)

</div>

## 🎥 데모 영상

[![Coinbean 데모](https://img.youtube.com/vi/2TaJvP5Ysfc/maxresdefault.jpg)](https://youtu.be/2TaJvP5Ysfc)

*YouTube에서 Coinbean 데모를 보려면 위 이미지를 클릭하세요*

## Coinbean이란?

Coinbean은 다음을 통해 암호화폐 포트폴리오를 추적하기 위한 구조화된 Beancount 원장 템플릿입니다:

- 다중 중앙화 거래소 (Coinbase, Binance, Kraken 등)
- 하드웨어 및 소프트웨어 지갑 (Ledger, Trezor, MetaMask, Phantom)
- DeFi 프로토콜 (Aave, Compound, Uniswap, Raydium, Jupiter 등)
- 영구 선물 DEX (Hyperliquid, dYdX, GMX)
- 리퀴드 스테이킹 프로토콜 (Lido, Rocket Pool, Jito, Marinade)
- 리스테이킹 프로토콜 (EigenLayer, Solayer)
- NFT 컬렉션 (BAYC, Azuki, DeGods, Bitcoin Ordinals 등)
- 스테이킹 및 이자 농사 활동
- Layer-1, Layer-2, DeFi, 스테이블코인, NFT 등에 걸쳐 110개 이상의 암호화폐

## 기능

- **포괄적인 자산 지원**: BTC, ETH, SOL 등을 포함한 110개 이상의 암호화폐 및 NFT 컬렉션을 사전 구성 지원
- **다중 거래소 지원**: 10개 이상의 주요 거래소에서 자산 추적 (Coinbase, Binance, Kraken, Gemini, Crypto.com 등)
- **DeFi 통합**: 대출, 유동성 풀 및 스테이킹 회계 처리
- **NFT 추적**: Ethereum, Solana, Bitcoin Ordinals, Polygon, Base의 인기 NFT 컬렉션 지원
- **Bitcoin Ordinals & BRC-20**: Ordinals 인스크립션 및 BRC-20 토큰 (ORDI, SATS 등) 추적
- **정밀한 소수점 처리**: 사토시, gwei 및 기타 작은 단위에 대한 허용 오차 구성
- **복식 부기**: 적절한 회계 원칙을 적용한 완전한 감사 추적
- **세금 신고 준비**: 다양한 소스의 양도소득세, 수수료 및 수입 추적
- **웹 인터페이스**: Fava를 통한 아름다운 시각화
- **간편한 설정**: 자동화된 설정 및 실행 스크립트 포함

## ⚡ 빠른 참조

| 스크립트         | 명령어        | 목적                                         |
| ---------------- | ------------- | -------------------------------------------- |
| **설정**         | `./setup.sh`  | Beancount & Fava 설치, 원장 검증             |
| **Fava 실행**    | `./run.sh`    | http://localhost:5002에서 웹 인터페이스 시작 |
| **가격 가져오기** | `./prices.sh` | 현재 암호화폐 가격 가져오기 (대화형 메뉴)     |

자세한 문서는 [도우미 스크립트](#도우미-스크립트) 섹션을 참조하세요.

## 빠른 시작

### 필수 조건

- Python 3.7+
- pip (Python 패키지 관리자)

### 세 가지 간단한 단계

**1단계: 설정**

```bash
cd /path/to/coinbean
./setup.sh
```

Beancount, Fava를 설치하고 원장 파일을 검증합니다.

**2단계: Fava 시작**

```bash
./run.sh
```

http://localhost:5002에서 웹 인터페이스를 시작합니다.

**3단계: 가격 가져오기**

```bash
./prices.sh
```

현재 암호화폐 가격을 가져오는 대화형 메뉴입니다.

> 📚 각 스크립트의 자세한 문서는 [도우미 스크립트](#도우미-스크립트) 섹션을 참조하세요.

### 수동 설치 (대안)

수동 설치를 선호하는 경우:

```bash
pip install beancount fava

# 설치 확인
bean-check crypto_main.beancount

# Fava 시작
fava -p 5002 crypto_main.beancount
```

### 첫 단계

1. **예제 검토**: `crypto_examples.beancount`를 열어 20개 이상의 거래 예제를 확인하세요
2. **가격 업데이트**: `./prices.sh`를 실행하여 현재 시장 가격을 가져오세요
3. **거래 추가**: `tx_2025.beancount`에서 기록을 시작하세요
4. **계정 사용자 지정**: 모듈식 파일 (`exchanges.beancount`, `chains.beancount`, `defi.beancount`)을 설정에 맞게 수정하세요
5. **Fava 탐색**: http://localhost:5002를 열어 포트폴리오를 시각화하세요

## 파일 구조

Coinbean은 더 나은 구성을 위해 **모듈식 구조**를 사용합니다:

```
crypto/
├── crypto_main.beancount       # 상품 및 가져오기가 포함된 기본 원장
├── exchanges.beancount         # 중앙화 거래소 계정
├── chains.beancount            # 블록체인 지갑 및 네이티브 스테이킹
├── defi.beancount              # DeFi 프로토콜, 리퀴드 스테이킹, 리스테이킹
├── crypto_prices.beancount     # 모든 자산의 가격 데이터
├── tx_2024.beancount           # 2024년 거래
├── tx_2025.beancount           # 2025년 거래
├── crypto_examples.beancount   # 20개 이상의 거래 예제 (참조)
├── fetch_prices.py             # CoinGecko에서 자동 가격 가져오기
├── prices.sh                   # fetch_prices.py용 편리한 래퍼
├── setup.sh                    # 자동 설정 및 설치 스크립트
├── run.sh                      # Fava 웹 인터페이스 시작
└── README.md                   # 이 파일
```

## 계정 구조

Coinbean은 계층적 계정 구조를 가진 Beancount의 **복식 부기** 원칙을 따릅니다:

```
Assets:Crypto
├── Exchange                    # 중앙화 거래소
│   ├── Coinbase
│   │   ├── Cash:USD           # 법정화폐 잔액
│   │   ├── BTC                # Bitcoin 잔액
│   │   ├── ETH                # Ethereum 잔액
│   │   └── Other              # 기타 토큰
│   ├── Binance
│   ├── Kraken
│   └── [10개 이상의 거래소...]
│
├── Wallet                      # 자기 관리 지갑
│   ├── Ledger                 # 하드웨어 지갑
│   │   ├── BTC
│   │   └── ETH
│   ├── MetaMask               # 소프트웨어 지갑
│   ├── Phantom
│   └── [더 많은 지갑...]
│
├── Staking                     # 네이티브 블록체인 스테이킹
│   ├── ETH
│   │   ├── Delegated          # 스테이킹된 금액
│   │   └── Rewards            # 획득한 보상
│   ├── SOL
│   ├── ADA
│   └── [더 많은 체인...]
│
├── DeFi                        # DeFi 프로토콜
│   ├── Aave                   # 대출
│   │   ├── USDC
│   │   └── ETH
│   ├── Uniswap                # DEX
│   │   └── LPTokens
│   ├── Hyperliquid            # 영구 선물 DEX
│   ├── Lido                   # 리퀴드 스테이킹
│   │   └── STETH
│   └── [더 많은 프로토콜...]
│
└── NFT                         # NFT 컬렉션
    ├── Ethereum
    │   ├── BAYC
    │   ├── Azuki
    │   └── [더 많은 컬렉션...]
    ├── Solana
    │   ├── DeGods
    │   └── MadLads
    └── Bitcoin
        └── NodeMonkes

Liabilities:Crypto
└── DeFi                        # DeFi 대출
    ├── Aave:Borrowed
    └── Compound:Borrowed

Income:Crypto
├── Staking:Rewards             # 스테이킹 수입
├── Mining:Rewards              # 채굴 수입
├── Airdrops                    # 에어드랍 토큰
├── Referrals                   # 추천 보너스
└── Trading:CapitalGains        # 실현 이익

Expenses:Crypto
├── Trading:Fees                # 거래소 수수료
├── Withdrawal:Fees             # 출금 수수료
├── Gas                         # 거래 수수료
│   ├── Ethereum
│   ├── Solana
│   └── [다른 체인...]
└── Trading:Losses              # 실현 손실

Equity:Opening-Balances         # 초기 잔액
```

### 계정 명명 규칙

Coinbean은 일관된 계층적 명명 구조를 사용합니다:

```
Assets:Crypto:{유형}:{플랫폼}:{자산}
             └──┬──┘ └────┬────┘ └──┬──┘
              유형     플랫폼     특정
                                  토큰
```

**예:**

- `Assets:Crypto:Exchange:Coinbase:BTC` - Coinbase의 Bitcoin
- `Assets:Crypto:Wallet:Ledger:ETH` - Ledger의 Ethereum
- `Assets:Crypto:DeFi:Aave:USDC` - Aave에 예치된 USDC
- `Assets:Crypto:Staking:SOL:Delegated` - 스테이킹된 Solana
- `Assets:Crypto:NFT:Ethereum:BAYC` - Bored Ape Yacht Club NFT

**팁:**

- 플랫폼 이름에는 CamelCase 사용 (예: `MetaMask`, `metamask` 아님)
- 자산 티커는 대문자로 유지 (예: `BTC`, `ETH`)
- 모든 거래에서 일관성 유지

## 거래 예제

### 거래소에서 암호화폐 구매

```beancount
2025-01-15 * "Coinbase" "Bitcoin 구매"
  Assets:Crypto:Exchange:Coinbase:BTC     0.5 BTC {50000.00 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD  -25000.00 USD
  Expenses:Crypto:Trading:Fees                   50.00 USD
```

### 콜드 스토리지로 전송

```beancount
2025-01-16 * "Ledger로 전송" "하드웨어 지갑으로 BTC 이동"
  Assets:Crypto:Wallet:Ledger:BTC            0.5 BTC
  Assets:Crypto:Exchange:Coinbase:BTC       -0.5 BTC
  Expenses:Crypto:Withdrawal:Fees          0.0001 BTC
```

### 스테이킹 보상

```beancount
2025-01-20 * "스테이킹 보상" "ETH 스테이킹 보상"
  Assets:Crypto:Staking:ETH              0.05 ETH
  Income:Crypto:Staking:Rewards         -0.05 ETH {2500.00 USD}
```

### DeFi 대출

```beancount
2025-01-25 * "Aave" "대출을 위한 USDC 예치"
  Assets:Crypto:DeFi:Aave:USDC              5000 USDC
  Assets:Crypto:Wallet:MetaMask:USDC       -5000 USDC
  Expenses:Crypto:Gas:Ethereum                 15.00 USD
```

## 지원되는 자산

### Layer-1 블록체인

BTC, ETH, SOL, ADA, DOT, AVAX, ATOM, ALGO, XRP, XLM, NEAR, FTM, TON, APT, SUI, LTC, BCH, ETC 등

### Layer-2 솔루션

MATIC, OP, ARB

### 스테이블코인

USDT, USDC, DAI, BUSD, TUSD

### DeFi 토큰

UNI, AAVE, MKR, COMP, SNX, CRV, SUSHI

### 거래소 토큰

BNB, CRO, FTT

### 영구 선물 DEX

HYPE (Hyperliquid), DYDX (dYdX), GMX

### Solana DEX

RAY (Raydium), JUP (Jupiter), ORCA (Orca)

### 리퀴드 스테이킹 & 리스테이킹

- **Ethereum**: LDO (Lido), STETH, RPL (Rocket Pool), RETH, EIGEN (EigenLayer)
- **Solana**: JTO (Jito), JITOSOL, MNDE (Marinade), MSOL

### NFT 생태계 토큰

APE (ApeCoin), LOOKS (LooksRare), X2Y2, SUDO (Sudoswap), BLUR (Blur), NFT (APENFT)

### Bitcoin Ordinals & BRC-20

ORDI (Ordinals), SATS, RATS, PUPS (Bitcoin Puppets), TRAC

### 지원되는 NFT 컬렉션

- **Ethereum**: BAYC, MAYC, Azuki, CloneX, Doodles, Pudgy Penguins, Moonbirds, Cryptopunks, Meebits, Art Blocks, PROOF Collective
- **Solana**: DeGods, y00ts, Mad Lads, Solana Monkey Business, Okay Bears, Tensorians
- **Bitcoin Ordinals**: NodeMonkes, Bitcoin Puppets, Quantum Cats, Ordinal Inscriptions
- **Polygon**: Reddit Collectible Avatars
- **Base**: Based Fellas

## 리소스

다음에 대해 자세히 알아보려면 [coinbean.org/docs](http://coinbean.org/docs)를 방문하세요:

- 고급 거래 패턴
- 세금 신고 전략
- 다른 도구와의 통합
- 커뮤니티 모범 사례

**프로젝트 링크:**

- 📦 [GitHub 저장소](https://github.com/qai-lab/coinbean) - 소스 코드, 이슈 및 기여
- 📋 [릴리스 노트](https://github.com/qai-lab/coinbean/releases) - 버전 히스토리 및 체인지로그
- 🌐 [Coinbean 웹사이트](https://coinbean.org/) - 공식 웹사이트 및 문서
- 🐦 [Coinbean X/Twitter](https://x.com/coinbean_org) - 업데이트 및 뉴스 팔로우
- 📚 [Beancount 문서](https://beancount.github.io/docs/) - Beancount 학습
- 🖥️ [Fava - 웹 인터페이스](https://github.com/beancount/fava) - Beancount 웹 인터페이스
- 💬 [Plain Text Accounting](https://plaintextaccounting.org/) - 커뮤니티 및 리소스

## 기여

기여를 환영합니다! Pull Request를 자유롭게 제출하세요. 기여 영역:

- 추가 거래소 템플릿
- 더 많은 DeFi 프로토콜
- 거래 가져오기를 위한 자동화 스크립트
- 문서 개선

## 저자

**Coinbean**은 다음에 의해 제작 및 유지 관리됩니다:

- **Boyuan Qian**
  - 🐙 GitHub: [@boyuanqian](https://github.com/boyuanqian)
  - 🐦 X/Twitter: [@boyuan_qian](https://x.com/boyuan_qian)
  - 🏢 조직: [QAI Lab](https://github.com/qai-lab)

**QAI Lab**

- 🌐 웹사이트: [qai.io](https://qai.io)
- 🐙 GitHub: [@qai-lab](https://github.com/qai-lab)
- 🐦 X/Twitter: [@qai_lab](https://x.com/qai_lab)

## 라이선스

MIT 라이선스 - Copyright (c) 2025 Boyuan Qian 및 QAI Lab

자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

이 템플릿은 개인 사용을 위해 있는 그대로 제공됩니다. 포트폴리오 추적 필요에 맞게 사용자 지정하세요.

## 면책 조항

이것은 개인 재무 추적 도구입니다. 다음을 제공하지 않습니다:

- 재무 조언
- 세금 조언
- 투자 권장 사항

재무 및 세금 문제에 대해서는 항상 자격을 갖춘 전문가와 상담하세요. 암호화폐 투자는 위험하며 자본 손실을 초래할 수 있습니다.

---

**즐거운 추적! 📊💰**
