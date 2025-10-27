<div align="center">
  <img src="images/banner.png" alt="Banner de Coinbean" width="100%">
</div>

<div align="center">

Un sistema integral de seguimiento de portafolio de criptomonedas basado en [Beancount](https://github.com/beancount/beancount), el sistema de contabilidad por partida doble.

**Creado por [Boyuan Qian](https://github.com/boyuanqian) @ [QAI Lab](https://github.com/qai-lab)**

[English](README.md) | [简体中文](README_zh.md) | [Français](README_fr.md) | [한국어](README_ko.md) | [日本語](README_ja.md) | Español

---

🌐 [coinbean.org](https://coinbean.org) | 🐦 [x.com/coinbean_org](https://x.com/coinbean_org)

</div>

## 🎥 Video de demostración

[![Demo de Coinbean](https://img.youtube.com/vi/2TaJvP5Ysfc/maxresdefault.jpg)](https://youtu.be/2TaJvP5Ysfc)

## ⚡ Inicio rápido

### Opción 1: Docker (Recomendado)

```bash
./run.sh  # Seleccione la opción 1 para Docker
# O: docker-compose up -d
```

### Opción 2: Instalación nativa

```bash
./setup.sh              # Instalar dependencias
./run.sh                # Iniciar interfaz web Fava
./prices.sh             # Obtener precios actuales
```

Abra http://localhost:5002 para ver su portafolio.

## ¿Qué es Coinbean?

Coinbean es una plantilla de registro Beancount estructurada para rastrear portafolios de criptomonedas a través de:

- Múltiples exchanges centralizados (Coinbase, Binance, Kraken, etc.)
- Billeteras de hardware y software (Ledger, Trezor, MetaMask, Phantom)
- Protocolos DeFi (Aave, Compound, Uniswap, Raydium, Jupiter, etc.)
- DEX perpetuos (Hyperliquid, dYdX, GMX)
- Protocolos de staking líquido (Lido, Rocket Pool, Jito, Marinade)
- Protocolos de restaking (EigenLayer, Solayer)
- Colecciones NFT (BAYC, Azuki, DeGods, Bitcoin Ordinals, y más)
- Actividades de staking y yield farming
- Más de 110 criptomonedas a través de Layer-1, Layer-2, DeFi, stablecoins, NFTs, y más

## Características

- **Cobertura integral de activos**: Soporte preconfigurado para más de 110 criptomonedas y colecciones NFT incluyendo BTC, ETH, SOL, y muchas más
- **Soporte multi-exchange**: Rastrea activos en más de 10 exchanges principales (Coinbase, Binance, Kraken, Gemini, Crypto.com, etc.)
- **Integración DeFi**: Contabilidad para préstamos, pools de liquidez y staking
- **Seguimiento de NFT**: Soporte para colecciones NFT populares en Ethereum, Solana, Bitcoin Ordinals, Polygon y Base
- **Bitcoin Ordinals & BRC-20**: Rastrea inscripciones Ordinals y tokens BRC-20 (ORDI, SATS, etc.)
- **Manejo preciso de decimales**: Tolerancias configuradas para satoshis, gwei y otras unidades pequeñas
- **Contabilidad por partida doble**: Rastro de auditoría completo con principios contables apropiados
- **Listo para declaración de impuestos**: Rastrea ganancias de capital, comisiones e ingresos de diversas fuentes
- **Interfaz web**: Hermosa visualización con Fava
- **Configuración fácil**: Scripts de configuración y ejecución automatizados incluidos

## ⚡ Referencia rápida

| Script              | Comando       | Propósito                                    |
| ------------------- | ------------- | -------------------------------------------- |
| **Configuración**   | `./setup.sh`  | Instalar Beancount & Fava, validar registro |
| **Ejecutar Fava**   | `./run.sh`    | Iniciar interfaz web en http://localhost:5002 |
| **Obtener precios** | `./prices.sh` | Obtener precios actuales de criptomonedas (menú interactivo) |

Ver la sección [Scripts auxiliares](#scripts-auxiliares) para documentación detallada.

## Inicio rápido

### Requisitos previos

- Python 3.7+
- pip (gestor de paquetes Python)

### Tres pasos simples

**Paso 1: Configuración**

```bash
cd /ruta/a/coinbean
./setup.sh
```

Instala Beancount, Fava y valida tus archivos de registro.

**Paso 2: Iniciar Fava**

```bash
./run.sh
```

Lanza la interfaz web en http://localhost:5002

**Paso 3: Obtener precios**

```bash
./prices.sh
```

Menú interactivo para obtener precios actuales de criptomonedas.

> 📚 Ver la sección [Scripts auxiliares](#scripts-auxiliares) para documentación detallada de cada script.

### Instalación manual (Alternativa)

Si prefieres la instalación manual:

```bash
pip install beancount fava

# Verificar instalación
bean-check crypto_main.beancount

# Iniciar Fava
fava -p 5002 crypto_main.beancount
```

### Primeros pasos

1. **Revisa los ejemplos**: Abre `crypto_examples.beancount` para ver más de 20 ejemplos de transacciones
2. **Actualiza precios**: Ejecuta `./prices.sh` para obtener precios de mercado actuales
3. **Agrega tus transacciones**: Comienza a registrar en `tx_2025.beancount`
4. **Personaliza cuentas**: Modifica los archivos modulares (`exchanges.beancount`, `chains.beancount`, `defi.beancount`) según tu configuración
5. **Explora Fava**: Abre http://localhost:5002 para visualizar tu portafolio

## Estructura de archivos

Coinbean utiliza una **estructura modular** para mejor organización:

```
crypto/
├── crypto_main.beancount       # Registro principal con commodities e imports
├── exchanges.beancount         # Cuentas de exchanges centralizados
├── chains.beancount            # Billeteras blockchain y staking nativo
├── defi.beancount              # Protocolos DeFi, staking líquido, restaking
├── crypto_prices.beancount     # Datos de precios para todos los activos
├── tx_2024.beancount           # Transacciones 2024
├── tx_2025.beancount           # Transacciones 2025
├── crypto_examples.beancount   # Más de 20 ejemplos de transacciones (referencia)
├── fetch_prices.py             # Obtención automática de precios desde CoinGecko
├── prices.sh                   # Wrapper conveniente para fetch_prices.py
├── setup.sh                    # Script de configuración e instalación automatizado
├── run.sh                      # Iniciar interfaz web Fava
└── README.md                   # Este archivo
```

## Estructura de cuentas

Coinbean sigue los principios de **contabilidad por partida doble** de Beancount con una estructura de cuenta jerárquica:

```
Assets:Crypto
├── Exchange                    # Exchanges centralizados
│   ├── Coinbase
│   │   ├── Cash:USD           # Saldos fiat
│   │   ├── BTC                # Saldo Bitcoin
│   │   ├── ETH                # Saldo Ethereum
│   │   └── Other              # Otros tokens
│   ├── Binance
│   ├── Kraken
│   └── [Más de 10 exchanges...]
│
├── Wallet                      # Billeteras de autocustodia
│   ├── Ledger                 # Billeteras de hardware
│   │   ├── BTC
│   │   └── ETH
│   ├── MetaMask               # Billeteras de software
│   ├── Phantom
│   └── [Más billeteras...]
│
├── Staking                     # Staking nativo de blockchain
│   ├── ETH
│   │   ├── Delegated          # Cantidad en staking
│   │   └── Rewards            # Recompensas ganadas
│   ├── SOL
│   ├── ADA
│   └── [Más cadenas...]
│
├── DeFi                        # Protocolos DeFi
│   ├── Aave                   # Préstamos
│   │   ├── USDC
│   │   └── ETH
│   ├── Uniswap                # DEXs
│   │   └── LPTokens
│   ├── Hyperliquid            # DEX perpetuos
│   ├── Lido                   # Staking líquido
│   │   └── STETH
│   └── [Más protocolos...]
│
└── NFT                         # Colecciones NFT
    ├── Ethereum
    │   ├── BAYC
    │   ├── Azuki
    │   └── [Más colecciones...]
    ├── Solana
    │   ├── DeGods
    │   └── MadLads
    └── Bitcoin
        └── NodeMonkes

Liabilities:Crypto
└── DeFi                        # Préstamos DeFi
    ├── Aave:Borrowed
    └── Compound:Borrowed

Income:Crypto
├── Staking:Rewards             # Ingresos por staking
├── Mining:Rewards              # Ingresos por minería
├── Airdrops                    # Tokens de airdrop
├── Referrals                   # Bonos de referidos
└── Trading:CapitalGains        # Ganancias realizadas

Expenses:Crypto
├── Trading:Fees                # Comisiones de exchange
├── Withdrawal:Fees             # Comisiones de retiro
├── Gas                         # Comisiones de transacción
│   ├── Ethereum
│   ├── Solana
│   └── [Otras cadenas...]
└── Trading:Losses              # Pérdidas realizadas

Equity:Opening-Balances         # Saldos iniciales
```

### Convención de nomenclatura de cuentas

Coinbean utiliza una estructura de nomenclatura jerárquica consistente:

```
Assets:Crypto:{Tipo}:{Plataforma}:{Activo}
             └──┬──┘ └────┬────┘ └──┬──┘
              Tipo     Plataforma   Token
                                   específico
```

**Ejemplos:**

- `Assets:Crypto:Exchange:Coinbase:BTC` - Bitcoin en Coinbase
- `Assets:Crypto:Wallet:Ledger:ETH` - Ethereum en Ledger
- `Assets:Crypto:DeFi:Aave:USDC` - USDC depositado en Aave
- `Assets:Crypto:Staking:SOL:Delegated` - Solana en staking
- `Assets:Crypto:NFT:Ethereum:BAYC` - NFT Bored Ape Yacht Club

**Consejos:**

- Usa CamelCase para nombres de plataformas (ej: `MetaMask`, no `metamask`)
- Mantén los tickers de activos en MAYÚSCULAS (ej: `BTC`, `ETH`)
- Sé consistente en todas tus transacciones

## Ejemplos de transacciones

### Comprar cripto en un exchange

```beancount
2025-01-15 * "Coinbase" "Comprar Bitcoin"
  Assets:Crypto:Exchange:Coinbase:BTC     0.5 BTC {50000.00 USD}
  Assets:Crypto:Exchange:Coinbase:Cash:USD  -25000.00 USD
  Expenses:Crypto:Trading:Fees                   50.00 USD
```

### Transferir a almacenamiento en frío

```beancount
2025-01-16 * "Transferencia a Ledger" "Mover BTC a billetera de hardware"
  Assets:Crypto:Wallet:Ledger:BTC            0.5 BTC
  Assets:Crypto:Exchange:Coinbase:BTC       -0.5 BTC
  Expenses:Crypto:Withdrawal:Fees          0.0001 BTC
```

### Recompensas de staking

```beancount
2025-01-20 * "Recompensas de staking" "Recompensas de staking ETH"
  Assets:Crypto:Staking:ETH              0.05 ETH
  Income:Crypto:Staking:Rewards         -0.05 ETH {2500.00 USD}
```

### Préstamo DeFi

```beancount
2025-01-25 * "Aave" "Depositar USDC para préstamos"
  Assets:Crypto:DeFi:Aave:USDC              5000 USDC
  Assets:Crypto:Wallet:MetaMask:USDC       -5000 USDC
  Expenses:Crypto:Gas:Ethereum                 15.00 USD
```

## Activos soportados

### Blockchains Layer-1

BTC, ETH, SOL, ADA, DOT, AVAX, ATOM, ALGO, XRP, XLM, NEAR, FTM, TON, APT, SUI, LTC, BCH, ETC, y más

### Soluciones Layer-2

MATIC, OP, ARB

### Stablecoins

USDT, USDC, DAI, BUSD, TUSD

### Tokens DeFi

UNI, AAVE, MKR, COMP, SNX, CRV, SUSHI

### Tokens de exchange

BNB, CRO, FTT

### DEX perpetuos

HYPE (Hyperliquid), DYDX (dYdX), GMX

### DEX de Solana

RAY (Raydium), JUP (Jupiter), ORCA (Orca)

### Staking líquido & Restaking

- **Ethereum**: LDO (Lido), STETH, RPL (Rocket Pool), RETH, EIGEN (EigenLayer)
- **Solana**: JTO (Jito), JITOSOL, MNDE (Marinade), MSOL

### Tokens del ecosistema NFT

APE (ApeCoin), LOOKS (LooksRare), X2Y2, SUDO (Sudoswap), BLUR (Blur), NFT (APENFT)

### Bitcoin Ordinals & BRC-20

ORDI (Ordinals), SATS, RATS, PUPS (Bitcoin Puppets), TRAC

### Colecciones NFT soportadas

- **Ethereum**: BAYC, MAYC, Azuki, CloneX, Doodles, Pudgy Penguins, Moonbirds, Cryptopunks, Meebits, Art Blocks, PROOF Collective
- **Solana**: DeGods, y00ts, Mad Lads, Solana Monkey Business, Okay Bears, Tensorians
- **Bitcoin Ordinals**: NodeMonkes, Bitcoin Puppets, Quantum Cats, Ordinal Inscriptions
- **Polygon**: Reddit Collectible Avatars
- **Base**: Based Fellas

## Recursos

Visita [coinbean.org/docs](http://coinbean.org/docs) para aprender más sobre:

- Patrones de transacciones avanzados
- Estrategias de declaración de impuestos
- Integración con otras herramientas
- Mejores prácticas de la comunidad

**Enlaces del proyecto:**

- 📦 [Repositorio GitHub](https://github.com/qai-lab/coinbean) - Código fuente, problemas y contribuciones
- 📋 [Notas de versión](https://github.com/qai-lab/coinbean/releases) - Historial de versiones y registro de cambios
- 🌐 [Sitio web Coinbean](https://coinbean.org/) - Sitio web oficial y documentación
- 🐦 [Coinbean en X/Twitter](https://x.com/coinbean_org) - Sigue para actualizaciones y noticias
- 📚 [Documentación Beancount](https://beancount.github.io/docs/) - Aprende sobre Beancount
- 🖥️ [Fava - Interfaz web](https://github.com/beancount/fava) - Interfaz web de Beancount
- 💬 [Plain Text Accounting](https://plaintextaccounting.org/) - Comunidad y recursos

## Contribuir

¡Las contribuciones son bienvenidas! No dudes en enviar un Pull Request. Áreas de contribución:

- Plantillas de exchanges adicionales
- Más protocolos DeFi
- Scripts de automatización para importar transacciones
- Mejoras en la documentación

## Autor

**Coinbean** es creado y mantenido por:

- **Boyuan Qian**
  - 🐙 GitHub: [@boyuanqian](https://github.com/boyuanqian)
  - 🐦 X/Twitter: [@boyuan_qian](https://x.com/boyuan_qian)
  - 🏢 Organización: [QAI Lab](https://github.com/qai-lab)

**QAI Lab**

- 🌐 Sitio web: [qai.io](https://qai.io)
- 🐙 GitHub: [@qai-lab](https://github.com/qai-lab)
- 🐦 X/Twitter: [@qai_lab](https://x.com/qai_lab)

## Licencia

Licencia MIT - Copyright (c) 2025 Boyuan Qian y QAI Lab

Ver el archivo [LICENSE](LICENSE) para detalles.

Esta plantilla se proporciona tal cual para uso personal. Personaliza según tus necesidades de seguimiento de portafolio.

## Descargo de responsabilidad

Esta es una herramienta de seguimiento financiero personal. No proporciona:

- Asesoramiento financiero
- Asesoramiento fiscal
- Recomendaciones de inversión

Siempre consulta con profesionales calificados para asuntos financieros y fiscales. Las inversiones en criptomonedas son riesgosas y pueden resultar en pérdida de capital.

---

**¡Feliz seguimiento! 📊💰**
