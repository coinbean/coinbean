#!/bin/bash
# Start Fava web interface for Coinbean

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Default port
PORT=5002

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--port)
            PORT="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: ./run.sh [-p PORT]"
            echo ""
            echo "Options:"
            echo "  -p, --port PORT    Port number for Fava (default: 5002)"
            echo "  -h, --help         Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

echo -e "${BLUE}===========================================================${NC}"
echo -e "${BLUE}  Coinbean - Crypto Portfolio Tracker${NC}"
echo -e "${BLUE}===========================================================${NC}"
echo ""

# Check if fava is installed
if ! command -v fava &> /dev/null; then
    echo -e "${YELLOW}⚠ Fava is not installed${NC}"
    echo "Please run ./setup.sh first to install dependencies"
    exit 1
fi

# Validate the beancount file before starting
echo -e "${YELLOW}Validating ledger file...${NC}"
cd "$SCRIPT_DIR"
if bean-check crypto_main.beancount 2>&1; then
    echo -e "${GREEN}✓ Ledger file is valid${NC}"
else
    echo -e "${YELLOW}⚠ Validation warnings found (Fava will still start)${NC}"
fi
echo ""

echo -e "${GREEN}Starting Fava web interface...${NC}"
echo -e "Opening browser at ${BLUE}http://localhost:$PORT${NC}"
echo ""
echo "Press Ctrl+C to stop"
echo ""
echo -e "${BLUE}===========================================================${NC}"
echo ""

# Launch Fava from the crypto directory
cd "$SCRIPT_DIR"
fava -p "$PORT" crypto_main.beancount

# Fava will be accessible at http://localhost:$PORT
