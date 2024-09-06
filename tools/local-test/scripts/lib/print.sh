RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

function print_success {
    echo -e "${GREEN}#${NC} $1"
}

function print_error {
    echo -e "${RED}#${NC} $1"
}

function print_warn {
    echo -e "${YELLOW}#${NC} $1"
}