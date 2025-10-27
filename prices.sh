#!/bin/bash
#
# Coinbean Price Fetcher Wrapper
# Convenient wrapper script for fetch_prices.py
#
# Created by Boyuan Qian @ QAI Lab
#

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FETCH_SCRIPT="$SCRIPT_DIR/fetch_prices.py"

# Banner
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}  ${GREEN}Coinbean Price Fetcher${NC}                                    ${BLUE}║${NC}"
echo -e "${BLUE}║${NC}  Cryptocurrency prices from CoinGecko                      ${BLUE}║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo

# Check if fetch_prices.py exists
if [ ! -f "$FETCH_SCRIPT" ]; then
    echo -e "${YELLOW}Error: fetch_prices.py not found at $FETCH_SCRIPT${NC}"
    exit 1
fi

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}Error: Python 3 is not installed${NC}"
    exit 1
fi

# Check if requests library is installed
if ! python3 -c "import requests" 2>/dev/null; then
    echo -e "${YELLOW}Warning: 'requests' library not installed${NC}"
    echo "Installing requests..."
    pip3 install requests
fi

# If arguments are provided, pass them through directly
if [ $# -gt 0 ]; then
    python3 "$FETCH_SCRIPT" "$@"
    exit 0
fi

# Interactive menu when no arguments provided
echo -e "${GREEN}Select an option:${NC}"
echo "1. Show all cryptocurrency prices"
echo "2. Show specific tickers"
echo "3. List all supported assets"
echo "4. Exit"
echo
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo -e "${BLUE}Fetching all cryptocurrency prices...${NC}"
        echo
        python3 "$FETCH_SCRIPT"
        ;;
    2)
        echo
        read -p "Enter ticker symbols (space-separated, e.g., BTC ETH SOL): " tickers
        if [ -n "$tickers" ]; then
            echo -e "${BLUE}Fetching prices for: $tickers${NC}"
            echo
            python3 "$FETCH_SCRIPT" --ticker $tickers
        else
            echo -e "${YELLOW}No tickers entered. Exiting.${NC}"
        fi
        ;;
    3)
        echo -e "${BLUE}Listing all supported assets...${NC}"
        echo
        python3 "$FETCH_SCRIPT" --list
        ;;
    4)
        echo -e "${GREEN}Goodbye!${NC}"
        exit 0
        ;;
    *)
        echo -e "${YELLOW}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac
