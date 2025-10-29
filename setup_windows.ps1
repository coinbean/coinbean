# Setup script for Coinbean (Windows)
# This script validates your Beancount installation and ledger files
# Run with: powershell -ExecutionPolicy Bypass -File setup_windows.ps1

# Requires PowerShell 5.1 or later
#Requires -Version 5.1

# Set error action preference
$ErrorActionPreference = "Stop"

# Colors for output
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

function Write-Success($message) {
    Write-ColorOutput Green "✓ $message"
}

function Write-Error-Custom($message) {
    Write-ColorOutput Red "✗ $message"
}

function Write-Info($message) {
    Write-ColorOutput Cyan "$message"
}

function Write-Warning-Custom($message) {
    Write-ColorOutput Yellow "⚠ $message"
}

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-ColorOutput Blue "==========================================================="
Write-ColorOutput Blue "  Coinbean - Setup (Windows)"
Write-ColorOutput Blue "==========================================================="
Write-Output ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Warning-Custom "Not running as Administrator. Some installations may require elevated privileges."
    Write-Output "Consider running PowerShell as Administrator if you encounter permission issues."
    Write-Output ""
}

# Step 0: Choose installation method
Write-ColorOutput Yellow "Choose your installation method:"
Write-Output "1. Docker (recommended for easy setup)"
Write-Output "2. Native Python (for advanced users)"
Write-Output ""

$installationMethod = Read-Host "Enter your choice (1 or 2)"

if ($installationMethod -eq "1") {
    $installMethod = "docker"
    Write-Success "You selected: Docker"
} elseif ($installationMethod -eq "2") {
    $installMethod = "python"
    Write-Success "You selected: Native Python"
} else {
    Write-Error-Custom "Invalid choice. Please run the script again and select 1 or 2."
    exit 1
}
Write-Output ""

# Docker Installation Path
if ($installMethod -eq "docker") {
    Write-ColorOutput Yellow "[1/2] Checking Docker installation..."

    if (Get-Command docker -ErrorAction SilentlyContinue) {
        $dockerVersion = (docker --version) -replace 'Docker version ', '' -replace ',.*', ''
        Write-Success "Docker is installed (version $dockerVersion)"

        # Check if Docker daemon is running
        try {
            docker ps | Out-Null
            Write-Success "Docker daemon is running"
        } catch {
            Write-Error-Custom "Docker is installed but not running"
            Write-Output "Please start Docker Desktop and run this script again."
            exit 1
        }
    } else {
        Write-Error-Custom "Docker is not installed"
        Write-Output ""

        $response = Read-Host "Would you like to install Docker Desktop? (y/n)"
        if ($response -match '^[Yy]') {
            Write-Info "Installing Docker Desktop..."

            # Try using winget first
            if (Get-Command winget -ErrorAction SilentlyContinue) {
                Write-Info "Using Windows Package Manager (winget)..."
                try {
                    winget install -e --id Docker.DockerDesktop --accept-package-agreements --accept-source-agreements
                    Write-Success "Docker Desktop installed successfully"
                    Write-Warning-Custom "Please start Docker Desktop and run this script again."
                    exit 0
                } catch {
                    Write-Error-Custom "Failed to install Docker Desktop via winget"
                    Write-Output "Please install Docker Desktop manually from https://www.docker.com/products/docker-desktop"
                    exit 1
                }
            }
            # Try using chocolatey
            elseif (Get-Command choco -ErrorAction SilentlyContinue) {
                Write-Info "Using Chocolatey..."
                try {
                    choco install docker-desktop -y
                    Write-Success "Docker Desktop installed successfully"
                    Write-Warning-Custom "Please start Docker Desktop and run this script again."
                    exit 0
                } catch {
                    Write-Error-Custom "Failed to install Docker Desktop via Chocolatey"
                    Write-Output "Please install Docker Desktop manually from https://www.docker.com/products/docker-desktop"
                    exit 1
                }
            }
            # Manual installation
            else {
                Write-Warning-Custom "No package manager found (winget or chocolatey)"
                Write-Output "Please install Docker Desktop manually from https://www.docker.com/products/docker-desktop"
                Write-Output ""
                Write-Info "Or install winget (Windows 11 has it by default) or Chocolatey:"
                Write-Output "  - Chocolatey: https://chocolatey.org/install"
                exit 1
            }
        } else {
            Write-Output "Please install Docker Desktop manually from https://www.docker.com/products/docker-desktop"
            exit 1
        }
    }
    Write-Output ""

    Write-ColorOutput Yellow "[2/2] Setting up Docker environment..."

    # Check if docker-compose is available
    if ((Get-Command docker-compose -ErrorAction SilentlyContinue) -or (docker compose version 2>$null)) {
        Write-Success "Docker Compose is available"
    } else {
        Write-Warning-Custom "Docker Compose not found, but it should be included with Docker Desktop"
    }

    Write-Success "Docker setup complete"
    Write-Output ""
    Write-ColorOutput Blue "==========================================================="
    Write-ColorOutput Green "Setup completed successfully!"
    Write-ColorOutput Blue "==========================================================="
    Write-Output ""
    Write-Output "Your Coinbean crypto tracker is ready to use with Docker!"
    Write-Output ""
    Write-Output "Next steps:"
    Write-Output "  1. Review and customize the account templates in crypto_main.beancount"
    Write-Output "  2. Update crypto_prices.beancount with current cryptocurrency prices"
    Write-Output "  3. Add your transactions to tx_2024.beancount or tx_2025.beancount"
    Write-Output "  4. Start Fava with one of these commands:"
    Write-Output ""
    Write-Output "Docker commands:"
    Write-Output "  docker-compose up -d      # Start in background"
    Write-Output "  docker-compose logs -f    # View logs"
    Write-Output "  docker-compose down       # Stop container"
    Write-Output ""
    Write-Output "Or using Git Bash (if installed):"
    Write-Output "  ./run.sh                  # Interactive menu"
    Write-Output "  ./run.sh --docker         # Run directly with Docker"
    Write-Output ""
    exit 0
}

# Native Python Installation Path
# Step 1: Check if Python is installed
Write-ColorOutput Yellow "[1/5] Checking Python installation..."

if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonVersion = (python --version 2>&1) -replace 'Python ', ''
    Write-Success "Python is installed (version $pythonVersion)"
} elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    $pythonVersion = (python3 --version 2>&1) -replace 'Python ', ''
    Write-Success "Python 3 is installed (version $pythonVersion)"
} else {
    Write-Error-Custom "Python is not installed"
    Write-Output ""

    $response = Read-Host "Would you like to install Python? (y/n)"
    if ($response -match '^[Yy]') {
        Write-Info "Installing Python..."

        # Try using winget first
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Write-Info "Using Windows Package Manager (winget)..."
            try {
                winget install -e --id Python.Python.3.11 --accept-package-agreements --accept-source-agreements
                Write-Success "Python installed successfully"

                # Refresh PATH
                $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

                $pythonVersion = (python --version 2>&1) -replace 'Python ', ''
                Write-Success "Python version $pythonVersion is now available"
            } catch {
                Write-Error-Custom "Failed to install Python via winget"
                Write-Output "Please install Python manually from https://www.python.org/"
                exit 1
            }
        }
        # Try using chocolatey
        elseif (Get-Command choco -ErrorAction SilentlyContinue) {
            Write-Info "Using Chocolatey..."
            try {
                choco install python -y
                Write-Success "Python installed successfully"

                # Refresh PATH
                $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

                $pythonVersion = (python --version 2>&1) -replace 'Python ', ''
                Write-Success "Python version $pythonVersion is now available"
            } catch {
                Write-Error-Custom "Failed to install Python via Chocolatey"
                Write-Output "Please install Python manually from https://www.python.org/"
                exit 1
            }
        }
        # Manual installation
        else {
            Write-Warning-Custom "No package manager found (winget or chocolatey)"
            Write-Output "Please install Python manually from https://www.python.org/"
            Write-Output ""
            Write-Info "Or install winget (Windows 11 has it by default) or Chocolatey:"
            Write-Output "  - Chocolatey: https://chocolatey.org/install"
            exit 1
        }
    } else {
        Write-Output "Please install Python manually from https://www.python.org/"
        exit 1
    }
}
Write-Output ""

# Determine python command (python or python3)
$pythonCmd = "python"
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    if (Get-Command python3 -ErrorAction SilentlyContinue) {
        $pythonCmd = "python3"
    }
}

# Step 2: Check if Beancount is installed
Write-ColorOutput Yellow "[2/5] Checking Beancount installation..."

$beancountCheck = & $pythonCmd -c "import beancount" 2>&1
if ($LASTEXITCODE -eq 0) {
    $beancountVersion = & $pythonCmd -c "import beancount; print(beancount.__version__)" 2>&1
    if (-not $beancountVersion) { $beancountVersion = "unknown" }
    Write-Success "Beancount is installed (version $beancountVersion)"
} else {
    Write-Error-Custom "Beancount is not installed"
    Write-Output ""

    $response = Read-Host "Would you like to install Beancount now? (y/n)"
    if ($response -match '^[Yy]') {
        Write-Info "Installing Beancount..."
        & $pythonCmd -m pip install --user beancount
        Write-Success "Beancount installed successfully"
    } else {
        Write-Output "Please install Beancount manually: pip install beancount"
        exit 1
    }
}
Write-Output ""

# Step 3: Check if Fava is installed
Write-ColorOutput Yellow "[3/5] Checking Fava installation..."

if (Get-Command fava -ErrorAction SilentlyContinue) {
    $favaVersion = (fava --version 2>&1) -replace 'fava, version ', '' -replace '\r?\n.*', ''
    Write-Success "Fava is installed (version $favaVersion)"
} else {
    Write-Error-Custom "Fava is not installed"
    Write-Output ""

    $response = Read-Host "Would you like to install Fava now? (y/n)"
    if ($response -match '^[Yy]') {
        Write-Info "Installing Fava..."
        & $pythonCmd -m pip install --user fava

        # Refresh PATH for current session
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

        Write-Success "Fava installed successfully"
        Write-Warning-Custom "You may need to restart your terminal for the 'fava' command to be available"
    } else {
        Write-Output "Please install Fava manually: pip install fava"
        exit 1
    }
}
Write-Output ""

# Step 4: Validate Beancount files
Write-ColorOutput Yellow "[4/5] Validating Beancount ledger files..."
Set-Location $ScriptDir

if (Test-Path "crypto_main.beancount") {
    Write-Output "Checking crypto_main.beancount..."
    try {
        $checkOutput = bean-check crypto_main.beancount 2>&1
        Write-Success "crypto_main.beancount is valid"
    } catch {
        Write-Warning-Custom "crypto_main.beancount has warnings (this is often okay)"
    }
} else {
    Write-Error-Custom "crypto_main.beancount not found"
    exit 1
}
Write-Output ""

# Step 5: Optional - Install price fetching tools
Write-ColorOutput Yellow "[5/5] Optional: Install price fetching tools"
$response = Read-Host "Would you like to install beancount-price-sources for automated price fetching? (y/n)"
if ($response -match '^[Yy]') {
    Write-Info "Installing beancount-price-sources..."
    & $pythonCmd -m pip install --user beancount-price-sources
    Write-Success "Price fetching tools installed"
} else {
    Write-Output "Skipping price fetching tools installation"
}
Write-Output ""

# Final summary
Write-ColorOutput Blue "==========================================================="
Write-ColorOutput Green "Setup completed successfully!"
Write-ColorOutput Blue "==========================================================="
Write-Output ""
Write-Output "Your Coinbean crypto tracker is ready to use!"
Write-Output ""
Write-Output "Next steps:"
Write-Output "  1. Review and customize the account templates in crypto_main.beancount"
Write-Output "  2. Update crypto_prices.beancount with current cryptocurrency prices"
Write-Output "  3. Add your transactions to tx_2024.beancount or tx_2025.beancount"
Write-Output "  4. Run the Fava web interface with: fava crypto_main.beancount"
Write-Output ""
Write-Output "For detailed instructions, see README.md"
Write-Output ""
Write-Output "Useful commands:"
Write-Output "  fava crypto_main.beancount  - Start Fava web interface"
Write-Output "  bean-check crypto_main.beancount  - Validate your ledger"
Write-Output "  bean-report crypto_main.beancount balances  - View balances"
Write-Output ""
