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
USE_DOCKER=false
INTERACTIVE=false

# Check if no arguments were provided (interactive mode)
if [ $# -eq 0 ]; then
    INTERACTIVE=true
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--port)
            PORT="$2"
            shift 2
            ;;
        -d|--docker)
            USE_DOCKER=true
            shift
            ;;
        -h|--help)
            echo "Usage: ./run.sh [-p PORT] [-d]"
            echo ""
            echo "Interactive Mode:"
            echo "  ./run.sh              # Show menu to choose Docker or native"
            echo ""
            echo "Options:"
            echo "  -p, --port PORT    Port number for Fava (default: 5002)"
            echo "  -d, --docker       Run using Docker (docker-compose)"
            echo "  -h, --help         Show this help message"
            echo ""
            echo "Examples:"
            echo "  ./run.sh              # Interactive menu"
            echo "  ./run.sh -p 5003      # Run natively on port 5003"
            echo "  ./run.sh --docker     # Run using Docker"
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

# Interactive menu if no arguments provided
if [ "$INTERACTIVE" = true ]; then
    echo "Select how you want to run Coinbean:"
    echo ""
    echo "  1. Run with Docker (recommended)"
    echo "  2. Run natively (requires Python & Fava installed)"
    echo ""
    read -p "Enter your choice (1 or 2): " choice
    echo ""

    case $choice in
        1)
            USE_DOCKER=true
            ;;
        2)
            USE_DOCKER=false
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please run the script again and select 1 or 2.${NC}"
            exit 1
            ;;
    esac
fi

# Run with Docker if requested
if [ "$USE_DOCKER" = true ]; then
    echo -e "${GREEN}Starting Coinbean with Docker...${NC}"
    echo ""

    # Check if docker-compose is installed
    if ! command -v docker-compose &> /dev/null && ! command -v docker &> /dev/null; then
        echo -e "${YELLOW}⚠ Docker is not installed${NC}"
        echo "Please install Docker from https://www.docker.com/get-started"
        exit 1
    fi

    cd "$SCRIPT_DIR"

    # Check if docker-compose.yml exists
    if [ ! -f "docker-compose.yml" ]; then
        echo -e "${YELLOW}⚠ docker-compose.yml not found${NC}"
        exit 1
    fi

    # Stop any existing containers
    echo -e "${YELLOW}Stopping any existing containers...${NC}"
    docker-compose down 2>/dev/null

    # Start with docker-compose
    echo -e "${GREEN}Starting Docker container...${NC}"
    docker-compose up -d

    # Check if container started successfully
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✓ Docker container started successfully${NC}"
        echo ""
        echo -e "Coinbean is now running at ${BLUE}http://localhost:5002${NC}"
        echo ""
        echo "Useful commands:"
        echo "  docker-compose logs -f        # View logs"
        echo "  docker-compose down           # Stop container"
        echo "  docker-compose restart        # Restart container"
        echo ""
        echo -e "${BLUE}===========================================================${NC}"
    else
        echo -e "${YELLOW}⚠ Failed to start Docker container${NC}"
        echo "Check logs with: docker-compose logs"
        exit 1
    fi

    exit 0
fi

# Native installation path (non-Docker)
# Check if fava is installed
if ! command -v fava &> /dev/null; then
    echo -e "${YELLOW}⚠ Fava is not installed${NC}"
    echo "Please run ./setup.sh first to install dependencies"
    echo "Or use --docker flag to run with Docker: ./run.sh --docker"
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
