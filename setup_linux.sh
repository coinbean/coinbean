#!/bin/bash
# Setup script for Coinbean (Linux)
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

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    OS_VERSION=$VERSION_ID
else
    echo -e "${RED}Cannot detect Linux distribution${NC}"
    exit 1
fi

echo -e "${BLUE}===========================================================${NC}"
echo -e "${BLUE}  Coinbean - Setup (Linux)${NC}"
echo -e "${BLUE}  Detected OS: $OS $OS_VERSION${NC}"
echo -e "${BLUE}===========================================================${NC}"
echo ""

# Step 0: Choose installation method
echo -e "${YELLOW}Choose your installation method:${NC}"
echo "1. Docker (recommended for easy setup)"
echo "2. Native Python (for advanced users)"
echo ""
read -p "Enter your choice (1 or 2): " installation_method

if [[ "$installation_method" == "1" ]]; then
    INSTALL_METHOD="docker"
    echo -e "${GREEN}You selected: Docker${NC}"
elif [[ "$installation_method" == "2" ]]; then
    INSTALL_METHOD="python"
    echo -e "${GREEN}You selected: Native Python${NC}"
else
    echo -e "${RED}Invalid choice. Please run the script again and select 1 or 2.${NC}"
    exit 1
fi
echo ""

# Docker Installation Path
if [[ "$INSTALL_METHOD" == "docker" ]]; then
    echo -e "${YELLOW}[1/2] Checking Docker installation...${NC}"
    if command -v docker &> /dev/null; then
        DOCKER_VERSION=$(docker --version 2>&1 | awk '{print $3}' | sed 's/,$//')
        echo -e "${GREEN}✓ Docker is installed (version $DOCKER_VERSION)${NC}"

        # Check if Docker daemon is running
        if docker ps &> /dev/null; then
            echo -e "${GREEN}✓ Docker daemon is running${NC}"
        else
            echo -e "${RED}✗ Docker is installed but not running${NC}"
            echo "Please start Docker with: sudo systemctl start docker"
            echo "To enable Docker on boot: sudo systemctl enable docker"
            exit 1
        fi
    else
        echo -e "${RED}✗ Docker is not installed${NC}"
        echo ""
        echo "Would you like to install Docker? (y/n)"
        read -r response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            echo "Installing Docker..."

            case "$OS" in
                ubuntu|debian)
                    # Remove old versions
                    sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

                    # Install dependencies
                    sudo apt-get update
                    sudo apt-get install -y \
                        ca-certificates \
                        curl \
                        gnupg \
                        lsb-release

                    # Add Docker's official GPG key
                    sudo mkdir -p /etc/apt/keyrings
                    curl -fsSL https://download.docker.com/linux/$OS/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

                    # Set up repository
                    echo \
                        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$OS \
                        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

                    # Install Docker Engine
                    sudo apt-get update
                    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
                    ;;

                fedora|rhel|centos)
                    # Remove old versions
                    sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine 2>/dev/null || true

                    # Install dependencies
                    sudo yum install -y yum-utils

                    # Add Docker repository (use centos repo for RHEL)
                    DOCKER_REPO_OS=$OS
                    if [[ "$OS" == "rhel" ]]; then
                        DOCKER_REPO_OS="centos"
                    fi
                    sudo yum-config-manager --add-repo https://download.docker.com/linux/$DOCKER_REPO_OS/docker-ce.repo

                    # Install Docker Engine
                    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
                    ;;

                arch)
                    sudo pacman -Sy --noconfirm docker docker-compose
                    ;;

                *)
                    echo -e "${RED}Unsupported distribution: $OS${NC}"
                    echo "Please install Docker manually from https://docs.docker.com/engine/install/"
                    exit 1
                    ;;
            esac

            # Start and enable Docker
            sudo systemctl start docker
            sudo systemctl enable docker

            # Add current user to docker group
            sudo usermod -aG docker $USER

            echo -e "${GREEN}✓ Docker installed successfully${NC}"
            echo -e "${YELLOW}Note: You may need to log out and log back in for group changes to take effect${NC}"
            echo -e "${YELLOW}Or run: newgrp docker${NC}"
        else
            echo "Please install Docker manually from https://docs.docker.com/engine/install/"
            exit 1
        fi
    fi
    echo ""

    echo -e "${YELLOW}[2/2] Setting up Docker environment...${NC}"

    # Check if docker-compose is available
    if command -v docker-compose &> /dev/null || docker compose version &> /dev/null; then
        echo -e "${GREEN}✓ Docker Compose is available${NC}"
    else
        echo -e "${YELLOW}Installing Docker Compose...${NC}"
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        echo -e "${GREEN}✓ Docker Compose installed${NC}"
    fi

    echo -e "${GREEN}✓ Docker setup complete${NC}"
    echo ""
    echo -e "${BLUE}===========================================================${NC}"
    echo -e "${GREEN}Setup completed successfully!${NC}"
    echo -e "${BLUE}===========================================================${NC}"
    echo ""
    echo "Your Coinbean crypto tracker is ready to use with Docker!"
    echo ""
    echo "Next steps:"
    echo "  1. Review and customize the account templates in crypto_main.beancount"
    echo "  2. Update crypto_prices.beancount with current cryptocurrency prices"
    echo "  3. Add your transactions to tx_2024.beancount or tx_2025.beancount"
    echo "  4. Run './run.sh' and select option 1 for Docker"
    echo ""
    echo "Alternative Docker commands:"
    echo "  ./run.sh --docker         # Run directly with Docker"
    echo "  docker-compose up -d      # Start in background"
    echo "  docker-compose logs -f    # View logs"
    echo ""
    echo "If you get permission errors, run: newgrp docker"
    echo ""
    exit 0
fi

# Native Python Installation Path
# Step 1: Check if Python is installed
echo -e "${YELLOW}[1/5] Checking Python installation...${NC}"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    echo -e "${GREEN}✓ Python 3 is installed (version $PYTHON_VERSION)${NC}"
else
    echo -e "${RED}✗ Python 3 is not installed${NC}"
    echo ""
    echo "Would you like to install Python 3? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Installing Python 3..."

        case "$OS" in
            ubuntu|debian)
                sudo apt-get update
                sudo apt-get install -y python3 python3-pip python3-venv
                ;;
            fedora|rhel|centos)
                sudo yum install -y python3 python3-pip
                ;;
            arch)
                sudo pacman -Sy --noconfirm python python-pip
                ;;
            *)
                echo -e "${RED}Unsupported distribution: $OS${NC}"
                echo "Please install Python 3 manually from https://www.python.org/"
                exit 1
                ;;
        esac

        echo -e "${GREEN}✓ Python 3 installed successfully${NC}"
        PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
        echo -e "${GREEN}✓ Python 3 version $PYTHON_VERSION is now available${NC}"
    else
        echo "Please install Python 3 manually"
        exit 1
    fi
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
        pip3 install --user beancount
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
        pip3 install --user fava

        # Add ~/.local/bin to PATH if not already there
        if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
            echo -e "${YELLOW}Adding ~/.local/bin to PATH...${NC}"
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
            export PATH="$HOME/.local/bin:$PATH"
        fi

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
    pip3 install --user beancount-price-sources
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
echo "  3. Add your transactions to tx_2024.beancount or tx_2025.beancount"
echo "  4. Run './run.sh' to start the Fava web interface"
echo ""
echo "For detailed instructions, see README.md"
echo ""
echo "Useful commands:"
echo "  ./run.sh              - Start Fava web interface"
echo "  bean-check crypto_main.beancount  - Validate your ledger"
echo "  bean-report crypto_main.beancount balances  - View balances"
echo ""
