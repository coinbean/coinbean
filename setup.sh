#!/bin/bash
# Setup script for Coinbean
# This script validates your Beancount installation and ledger files

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}===========================================================${NC}"
echo -e "${BLUE}  Coinbean - Setup${NC}"
echo -e "${BLUE}===========================================================${NC}"
echo ""

# Step 1: Check if Python is installed
echo -e "${YELLOW}[1/5] Checking Python installation...${NC}"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    echo -e "${GREEN}✓ Python 3 is installed (version $PYTHON_VERSION)${NC}"
else
    echo -e "${RED}✗ Python 3 is not installed${NC}"
    echo "Please install Python 3 from https://www.python.org/"
    exit 1
fi
echo ""

# Step 2: Check if Beancount is installed
echo -e "${YELLOW}[2/5] Checking Beancount installation...${NC}"
if python3 -c "import beancount" 2>/dev/null; then
    BEANCOUNT_VERSION=$(python3 -c "import beancount; print(beancount.__version__)" 2>/dev/null || echo "unknown")
    echo -e "${GREEN}✓ Beancount is installed (version $BEANCOUNT_VERSION)${NC}"
else
    echo -e "${RED}✗ Beancount is not installed${NC}"
    echo ""
    echo "Would you like to install Beancount now? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Installing Beancount..."
        pip3 install beancount
        echo -e "${GREEN}✓ Beancount installed successfully${NC}"
    else
        echo "Please install Beancount manually: pip3 install beancount"
        exit 1
    fi
fi
echo ""

# Step 3: Check if Fava is installed
echo -e "${YELLOW}[3/5] Checking Fava installation...${NC}"
if command -v fava &> /dev/null; then
    FAVA_VERSION=$(fava --version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
    echo -e "${GREEN}✓ Fava is installed (version $FAVA_VERSION)${NC}"
else
    echo -e "${RED}✗ Fava is not installed${NC}"
    echo ""
    echo "Would you like to install Fava now? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Installing Fava..."
        pip3 install fava
        echo -e "${GREEN}✓ Fava installed successfully${NC}"
    else
        echo "Please install Fava manually: pip3 install fava"
        exit 1
    fi
fi
echo ""

# Step 4: Validate Beancount files
echo -e "${YELLOW}[4/5] Validating Beancount ledger files...${NC}"
cd "$SCRIPT_DIR"

if [ -f "crypto_main.beancount" ]; then
    echo "Checking crypto_main.beancount..."
    if bean-check crypto_main.beancount 2>&1; then
        echo -e "${GREEN}✓ crypto_main.beancount is valid${NC}"
    else
        echo -e "${YELLOW}⚠ crypto_main.beancount has warnings (this is often okay)${NC}"
    fi
else
    echo -e "${RED}✗ crypto_main.beancount not found${NC}"
    exit 1
fi
echo ""

# Step 5: Optional - Install price fetching tools
echo -e "${YELLOW}[5/5] Optional: Install price fetching tools${NC}"
echo "Would you like to install beancount-price-sources for automated price fetching? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Installing beancount-price-sources..."
    pip3 install beancount-price-sources
    echo -e "${GREEN}✓ Price fetching tools installed${NC}"
else
    echo "Skipping price fetching tools installation"
fi
echo ""

# Final summary
echo -e "${BLUE}===========================================================${NC}"
echo -e "${GREEN}Setup completed successfully!${NC}"
echo -e "${BLUE}===========================================================${NC}"
echo ""
echo "Your Coinbean crypto tracker is ready to use!"
echo ""
echo "Next steps:"
echo "  1. Review and customize the account templates in crypto_main.beancount"
echo "  2. Update crypto_prices.beancount with current cryptocurrency prices"
echo "  3. Add your transactions to crypto_2024.beancount or crypto_2025.beancount"
echo "  4. Run './run.sh' to start the Fava web interface"
echo ""
echo "For detailed instructions, see README.md"
echo ""
echo "Useful commands:"
echo "  ./run.sh              - Start Fava web interface"
echo "  bean-check crypto_main.beancount  - Validate your ledger"
echo "  bean-report crypto_main.beancount balances  - View balances"
echo ""
