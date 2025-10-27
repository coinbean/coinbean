#!/usr/bin/env python3
"""
Coinbean Price Fetcher
Fetch cryptocurrency prices from CoinGecko API and output in Beancount format

Usage:
    python3 fetch_prices.py                    # Show all prices in table
    python3 fetch_prices.py --ticker BTC       # Show specific ticker
    python3 fetch_prices.py --ticker eth sol   # Show multiple tickers (case-insensitive)
    python3 fetch_prices.py --beancount        # Output Beancount format
    python3 fetch_prices.py --beancount >> crypto_prices.beancount  # Append to file

Created by Boyuan Qian @ QAI Lab
"""

import requests
import sys
from datetime import date
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass

# Asset metadata structure
@dataclass
class Asset:
    ticker: str
    name: str
    chain: str
    category: str
    coingecko_id: str

# Comprehensive asset mapping with chain information
ASSETS = [
    # Layer 1 Blockchains
    Asset('BTC', 'Bitcoin', 'Bitcoin', 'Layer-1', 'bitcoin'),
    Asset('ETH', 'Ethereum', 'Ethereum', 'Layer-1', 'ethereum'),
    Asset('SOL', 'Solana', 'Solana', 'Layer-1', 'solana'),
    Asset('ADA', 'Cardano', 'Cardano', 'Layer-1', 'cardano'),
    Asset('DOT', 'Polkadot', 'Polkadot', 'Layer-1', 'polkadot'),
    Asset('AVAX', 'Avalanche', 'Avalanche', 'Layer-1', 'avalanche-2'),
    Asset('ATOM', 'Cosmos', 'Cosmos', 'Layer-1', 'cosmos'),
    Asset('ALGO', 'Algorand', 'Algorand', 'Layer-1', 'algorand'),
    Asset('XRP', 'Ripple', 'Ripple', 'Layer-1', 'ripple'),
    Asset('XLM', 'Stellar', 'Stellar', 'Layer-1', 'stellar'),
    Asset('NEAR', 'NEAR Protocol', 'NEAR', 'Layer-1', 'near'),
    Asset('FTM', 'Fantom', 'Fantom', 'Layer-1', 'fantom'),
    Asset('TON', 'Toncoin', 'TON', 'Layer-1', 'the-open-network'),
    Asset('APT', 'Aptos', 'Aptos', 'Layer-1', 'aptos'),
    Asset('SUI', 'Sui', 'Sui', 'Layer-1', 'sui'),
    Asset('LTC', 'Litecoin', 'Litecoin', 'Layer-1', 'litecoin'),
    Asset('BCH', 'Bitcoin Cash', 'Bitcoin Cash', 'Layer-1', 'bitcoin-cash'),
    Asset('ETC', 'Ethereum Classic', 'Ethereum Classic', 'Layer-1', 'ethereum-classic'),
    Asset('VET', 'VeChain', 'VeChain', 'Layer-1', 'vechain'),
    Asset('HBAR', 'Hedera', 'Hedera', 'Layer-1', 'hedera-hashgraph'),
    Asset('ICP', 'Internet Computer', 'Internet Computer', 'Layer-1', 'internet-computer'),

    # Layer 2 Solutions
    Asset('MATIC', 'Polygon', 'Ethereum L2', 'Layer-2', 'matic-network'),
    Asset('OP', 'Optimism', 'Ethereum L2', 'Layer-2', 'optimism'),
    Asset('ARB', 'Arbitrum', 'Ethereum L2', 'Layer-2', 'arbitrum'),

    # Stablecoins
    Asset('USDT', 'Tether', 'Multi-chain', 'Stablecoin', 'tether'),
    Asset('USDC', 'USD Coin', 'Multi-chain', 'Stablecoin', 'usd-coin'),
    Asset('DAI', 'Dai', 'Ethereum', 'Stablecoin', 'dai'),
    Asset('BUSD', 'Binance USD', 'Multi-chain', 'Stablecoin', 'binance-usd'),
    Asset('TUSD', 'TrueUSD', 'Multi-chain', 'Stablecoin', 'true-usd'),

    # DeFi Tokens - Ethereum
    Asset('UNI', 'Uniswap', 'Ethereum', 'DEX', 'uniswap'),
    Asset('AAVE', 'Aave', 'Ethereum', 'Lending', 'aave'),
    Asset('MKR', 'Maker', 'Ethereum', 'Lending', 'maker'),
    Asset('COMP', 'Compound', 'Ethereum', 'Lending', 'compound-governance-token'),
    Asset('SNX', 'Synthetix', 'Ethereum', 'DeFi', 'synthetix-network-token'),
    Asset('CRV', 'Curve', 'Ethereum', 'DEX', 'curve-dao-token'),
    Asset('SUSHI', 'SushiSwap', 'Ethereum', 'DEX', 'sushi'),

    # Perpetual DEX
    Asset('HYPE', 'Hyperliquid', 'Hyperliquid L1', 'Perp DEX', 'hyperliquid'),
    Asset('DYDX', 'dYdX', 'dYdX Chain', 'Perp DEX', 'dydx-chain'),
    Asset('GMX', 'GMX', 'Arbitrum', 'Perp DEX', 'gmx'),

    # Solana Ecosystem
    Asset('RAY', 'Raydium', 'Solana', 'DEX', 'raydium'),
    Asset('JUP', 'Jupiter', 'Solana', 'DEX Aggregator', 'jupiter-exchange-solana'),
    Asset('ORCA', 'Orca', 'Solana', 'DEX', 'orca'),
    Asset('JTO', 'Jito', 'Solana', 'Liquid Staking', 'jito-governance-token'),
    Asset('JITOSOL', 'Jito Staked SOL', 'Solana', 'Liquid Staking', 'jito-staked-sol'),
    Asset('MNDE', 'Marinade', 'Solana', 'Liquid Staking', 'marinade'),
    Asset('MSOL', 'Marinade SOL', 'Solana', 'Liquid Staking', 'msol'),

    # Ethereum Liquid Staking & Restaking
    Asset('LDO', 'Lido DAO', 'Ethereum', 'Liquid Staking', 'lido-dao'),
    Asset('STETH', 'Lido Staked ETH', 'Ethereum', 'Liquid Staking', 'staked-ether'),
    Asset('RPL', 'Rocket Pool', 'Ethereum', 'Liquid Staking', 'rocket-pool'),
    Asset('RETH', 'Rocket Pool ETH', 'Ethereum', 'Liquid Staking', 'rocket-pool-eth'),
    Asset('EIGEN', 'EigenLayer', 'Ethereum', 'Restaking', 'eigenlayer'),

    # Exchange Tokens
    Asset('BNB', 'BNB', 'BNB Chain', 'Exchange', 'binancecoin'),
    Asset('CRO', 'Cronos', 'Cronos', 'Exchange', 'crypto-com-chain'),
    Asset('FTT', 'FTX Token', 'Ethereum', 'Exchange', 'ftx-token'),

    # Meme Coins
    Asset('DOGE', 'Dogecoin', 'Dogecoin', 'Meme', 'dogecoin'),
    Asset('SHIB', 'Shiba Inu', 'Ethereum', 'Meme', 'shiba-inu'),
    Asset('PEPE', 'Pepe', 'Ethereum', 'Meme', 'pepe'),

    # Privacy Coins
    Asset('XMR', 'Monero', 'Monero', 'Privacy', 'monero'),
    Asset('ZEC', 'Zcash', 'Zcash', 'Privacy', 'zcash'),

    # Oracle & Infrastructure
    Asset('LINK', 'Chainlink', 'Multi-chain', 'Oracle', 'chainlink'),
]

# CoinGecko API endpoints
COINGECKO_API_BASE = "https://api.coingecko.com/api/v3"
SIMPLE_PRICE_ENDPOINT = f"{COINGECKO_API_BASE}/simple/price"


def fetch_prices(assets: List[Asset], vs_currency: str = 'usd') -> Dict[str, Optional[float]]:
    """
    Fetch prices for multiple cryptocurrencies from CoinGecko.

    Args:
        assets: List of Asset objects to fetch prices for
        vs_currency: Currency to get prices in (default: 'usd')

    Returns:
        Dictionary mapping coingecko_id to prices (None if fetch failed)
    """
    # CoinGecko allows up to 100 coins per request
    coin_ids = [asset.coingecko_id for asset in assets]
    coin_ids_str = ','.join(coin_ids)

    try:
        params = {
            'ids': coin_ids_str,
            'vs_currencies': vs_currency
        }

        response = requests.get(SIMPLE_PRICE_ENDPOINT, params=params, timeout=30)
        response.raise_for_status()
        data = response.json()

        # Map back to coingecko_id
        prices = {}
        for asset in assets:
            if asset.coingecko_id in data and vs_currency in data[asset.coingecko_id]:
                prices[asset.coingecko_id] = data[asset.coingecko_id][vs_currency]
            else:
                prices[asset.coingecko_id] = None
                print(f"Warning: Could not fetch price for {asset.ticker} ({asset.coingecko_id})", file=sys.stderr)

        return prices

    except requests.RequestException as e:
        print(f"Error fetching prices from CoinGecko: {e}", file=sys.stderr)
        return {asset.coingecko_id: None for asset in assets}
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        return {asset.coingecko_id: None for asset in assets}


def format_price(price: Optional[float]) -> str:
    """Format price with appropriate precision."""
    if price is None:
        return "N/A"

    if price < 0.000001:
        return f"${price:.10f}"
    elif price < 0.01:
        return f"${price:.8f}"
    elif price < 1:
        return f"${price:.6f}"
    elif price < 100:
        return f"${price:.4f}"
    else:
        return f"${price:,.2f}"


def display_table(assets: List[Asset], prices: Dict[str, Optional[float]]):
    """Display prices in a formatted table."""

    # Table header
    print("\n" + "=" * 110)
    print(f"{'TICKER':<10} {'NAME':<25} {'CHAIN':<20} {'CATEGORY':<18} {'PRICE':<15}")
    print("=" * 110)

    # Group by category for better organization
    categories = {}
    for asset in assets:
        if asset.category not in categories:
            categories[asset.category] = []
        categories[asset.category].append(asset)

    # Sort categories for consistent display
    category_order = ['Layer-1', 'Layer-2', 'Stablecoin', 'DEX', 'DEX Aggregator', 'Perp DEX',
                     'Lending', 'Liquid Staking', 'Restaking', 'Exchange', 'Oracle',
                     'Meme', 'Privacy', 'DeFi']

    for category in category_order:
        if category not in categories:
            continue

        print(f"\n# {category}")
        print("-" * 110)

        for asset in sorted(categories[category], key=lambda x: x.ticker):
            price = prices.get(asset.coingecko_id)
            price_str = format_price(price)
            print(f"{asset.ticker:<10} {asset.name:<25} {asset.chain:<20} {asset.category:<18} {price_str:<15}")

    print("=" * 110)

    # Summary
    successful = sum(1 for p in prices.values() if p is not None)
    total = len(prices)
    print(f"\nFetched {successful}/{total} prices successfully")
    print(f"Date: {date.today().isoformat()}")
    print()


def format_beancount_price(date_str: str, ticker: str, price: float, currency: str = 'USD') -> str:
    """
    Format a price entry in Beancount format.

    Args:
        date_str: Date in YYYY-MM-DD format
        ticker: Commodity symbol
        price: Price value
        currency: Currency (default: USD)

    Returns:
        Formatted price line
    """
    # Format price with appropriate precision
    if price < 0.000001:
        price_str = f"{price:.10f}"
    elif price < 0.01:
        price_str = f"{price:.8f}"
    elif price < 1:
        price_str = f"{price:.6f}"
    elif price < 100:
        price_str = f"{price:.4f}"
    else:
        price_str = f"{price:.2f}"

    return f"{date_str} price {ticker} {price_str} {currency}"


def print_beancount(assets: List[Asset], prices: Dict[str, Optional[float]], date_str: str = None):
    """
    Print prices in Beancount format.

    Args:
        assets: List of assets
        prices: Dictionary of coingecko_id -> price
        date_str: Date string (default: today)
    """
    if date_str is None:
        date_str = date.today().isoformat()

    print(f";;; Cryptocurrency Prices")
    print(f";;; Fetched on: {date_str}")
    print(f";;; Source: CoinGecko API")
    print()

    # Group by category for better organization
    categories = {}
    for asset in assets:
        if asset.category not in categories:
            categories[asset.category] = []
        categories[asset.category].append(asset)

    category_order = ['Layer-1', 'Layer-2', 'Stablecoin', 'DEX', 'DEX Aggregator', 'Perp DEX',
                     'Lending', 'Liquid Staking', 'Restaking', 'Exchange', 'Oracle',
                     'Meme', 'Privacy', 'DeFi']

    for category in category_order:
        if category not in categories:
            continue

        print(f";; {category}")
        for asset in sorted(categories[category], key=lambda x: x.ticker):
            price = prices.get(asset.coingecko_id)
            if price is not None:
                print(format_beancount_price(date_str, asset.ticker, price))
        print()


def filter_assets_by_ticker(assets: List[Asset], tickers: List[str]) -> List[Asset]:
    """
    Filter assets by ticker symbols (case-insensitive).
    Returns all assets that match any of the provided tickers.
    """
    # Normalize tickers to uppercase for comparison
    normalized_tickers = [t.upper() for t in tickers]

    filtered = []
    for asset in assets:
        if asset.ticker.upper() in normalized_tickers:
            filtered.append(asset)

    return filtered


def main():
    """Main function to fetch and display cryptocurrency prices."""
    import argparse

    parser = argparse.ArgumentParser(
        description='Fetch cryptocurrency prices from CoinGecko API',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 fetch_prices.py                           # Show all prices in table format
  python3 fetch_prices.py --ticker BTC              # Show Bitcoin price
  python3 fetch_prices.py --ticker eth sol usdc     # Show multiple assets (case-insensitive)
  python3 fetch_prices.py --beancount               # Output Beancount format
  python3 fetch_prices.py --beancount >> crypto_prices.beancount  # Append to file
  python3 fetch_prices.py --list                    # List all supported assets

Note: CoinGecko API has rate limits. For free tier, limit is ~50 calls/minute.
        """
    )

    parser.add_argument(
        '--ticker',
        type=str,
        nargs='+',
        help='Show specific ticker(s) only (case-insensitive, shows all matches if duplicate)'
    )

    parser.add_argument(
        '--beancount',
        action='store_true',
        help='Output in Beancount format instead of table'
    )

    parser.add_argument(
        '--date',
        type=str,
        default=None,
        help='Date for price entries (default: today, format: YYYY-MM-DD)'
    )

    parser.add_argument(
        '--currency',
        type=str,
        default='usd',
        choices=['usd', 'eur', 'gbp', 'jpy', 'cny'],
        help='Currency to fetch prices in (default: usd)'
    )

    parser.add_argument(
        '--list',
        action='store_true',
        help='List all supported assets with chain info and exit'
    )

    args = parser.parse_args()

    # List supported assets
    if args.list:
        print("\nSupported Assets:")
        print("=" * 110)
        print(f"{'TICKER':<10} {'NAME':<25} {'CHAIN':<20} {'CATEGORY':<18} {'COINGECKO ID':<25}")
        print("=" * 110)

        for asset in sorted(ASSETS, key=lambda x: x.ticker):
            print(f"{asset.ticker:<10} {asset.name:<25} {asset.chain:<20} {asset.category:<18} {asset.coingecko_id:<25}")

        print("=" * 110)
        print(f"\nTotal: {len(ASSETS)} assets")
        return

    # Determine which assets to fetch
    assets_to_fetch = ASSETS
    if args.ticker:
        assets_to_fetch = filter_assets_by_ticker(ASSETS, args.ticker)
        if not assets_to_fetch:
            print(f"Error: No assets found matching ticker(s): {', '.join(args.ticker)}", file=sys.stderr)
            print("Use --list to see all supported assets", file=sys.stderr)
            sys.exit(1)

        # Inform user if there are duplicate tickers
        ticker_counts = {}
        for ticker in args.ticker:
            ticker_upper = ticker.upper()
            matches = [a for a in assets_to_fetch if a.ticker.upper() == ticker_upper]
            if len(matches) > 1:
                print(f"Found {len(matches)} assets for ticker '{ticker}':", file=sys.stderr)
                for asset in matches:
                    print(f"  - {asset.ticker} ({asset.name}) on {asset.chain}", file=sys.stderr)

    # Fetch prices
    print(f"Fetching prices for {len(assets_to_fetch)} asset(s)...", file=sys.stderr)
    prices = fetch_prices(assets_to_fetch, vs_currency=args.currency)

    # Count successful fetches
    successful = sum(1 for p in prices.values() if p is not None)
    print(f"Successfully fetched {successful}/{len(assets_to_fetch)} prices", file=sys.stderr)
    print("=" * 50, file=sys.stderr)

    # Display results
    if args.beancount:
        print_beancount(assets_to_fetch, prices, date_str=args.date)
    else:
        display_table(assets_to_fetch, prices)


if __name__ == '__main__':
    main()
