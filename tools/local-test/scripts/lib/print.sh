RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
NC='\033[0m'
RESET=$(tput sgr0)
BOLD=$(tput bold)

function print_state {
    if [[ $? -eq 0 ]]; then
        echo -e "  ${GREEN}✓  ${RESET} $1. ${GREEN}Успешно${RESET}"
    else
        echo -e "  ${RED}×  ${RESET} $1. ${RED}Не удалось${RESET}"
    fi
}

function print_success {
    echo -e "  ${GREEN}🟢 ${RESET} $1"
}

function print_run {
    echo -e "  ${BOLD}${GREEN}⭆  ${RESET} $1"
}

function print_error {
    echo -e "  ${RED}🔴 ${RESET} $1 "
}

function print_info {
    echo -e "  ${BLUE}🛈  ${RESET} $1"
}

function print_warn {
    echo -e "  ${YELLOW}🟠 ${RESET} $1"
}