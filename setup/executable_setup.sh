#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  Fedora Setup Script${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

show_menu() {
    echo "Select components to install:"
    echo ""
    echo "1) Packages (DNF + Flatpak)"
    echo "2) Fonts (Nerd Fonts)"
    echo "3) Syncthing"
    echo "4) Docker"
    echo "5) Battery Threshold (ThinkPad)"
    echo "6) Oh-My-Zsh"
    echo "7) All of the above"
    echo "0) Exit"
    echo ""
}

run_packages() {
    print_info "Installing packages..."
    if bash "${SCRIPT_DIR}/packages.sh"; then
        print_success "Packages installed successfully"
    else
        print_error "Failed to install packages"
        return 1
    fi
}

run_fonts() {
    print_info "Installing fonts..."
    if bash "${SCRIPT_DIR}/fonts.sh"; then
        print_success "Fonts installed successfully"
    else
        print_error "Failed to install fonts"
        return 1
    fi
}

run_syncthing() {
    print_info "Setting up Syncthing..."
    if bash "${SCRIPT_DIR}/syncthing.sh"; then
        print_success "Syncthing setup completed"
    else
        print_error "Failed to setup Syncthing"
        return 1
    fi
}

run_docker() {
    print_info "Setting up Docker..."
    if bash "${SCRIPT_DIR}/docker.sh"; then
        print_success "Docker setup completed"
    else
        print_error "Failed to setup Docker"
        return 1
    fi
}

run_battery() {
    print_info "Setting up battery threshold..."
    if bash "${SCRIPT_DIR}/battery-threshold.sh"; then
        print_success "Battery threshold setup completed"
    else
        print_error "Failed to setup battery threshold"
        return 1
    fi
}

run_ohmyzsh() {
    print_info "Installing Oh-My-Zsh..."
    if bash "${SCRIPT_DIR}/ohmyzsh.sh"; then
        print_success "Oh-My-Zsh installed successfully"
    else
        print_error "Failed to install Oh-My-Zsh"
        return 1
    fi
}

run_all() {
    run_packages
    run_fonts
    run_syncthing
    run_docker
    run_battery
    run_ohmyzsh
}

interactive_mode() {
    print_header
    
    while true; do
        show_menu
        read -p "Enter your choice [0-7]: " choice
        
        case $choice in
            1) run_packages ;;
            2) run_fonts ;;
            3) run_syncthing ;;
            4) run_docker ;;
            5) run_battery ;;
            6) run_ohmyzsh ;;
            7) run_all ;;
            0) echo "Exiting..."; exit 0 ;;
            *) print_error "Invalid option. Please try again." ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
        clear
        print_header
    done
}

show_help() {
    cat << EOF
Fedora Setup Script

Usage: $0 [OPTIONS]

Options:
  --packages          Install DNF and Flatpak packages
  --fonts             Install Nerd Fonts
  --syncthing         Setup Syncthing service
  --docker            Setup Docker
  --battery           Setup ThinkPad battery threshold
  --ohmyzsh           Install Oh-My-Zsh
  --all               Run all setup scripts
  -h, --help          Show this help message

Examples:
  $0                  Run interactive menu
  $0 --all            Install everything
  $0 --packages --fonts   Install packages and fonts only
EOF
}

main() {
    if [ $# -eq 0 ]; then
        interactive_mode
    else
        print_header
        
        while [[ $# -gt 0 ]]; do
            case $1 in
                --packages)
                    run_packages
                    shift
                    ;;
                --fonts)
                    run_fonts
                    shift
                    ;;
                --syncthing)
                    run_syncthing
                    shift
                    ;;
                --docker)
                    run_docker
                    shift
                    ;;
                --battery)
                    run_battery
                    shift
                    ;;
                --ohmyzsh)
                    run_ohmyzsh
                    shift
                    ;;
                --all)
                    run_all
                    shift
                    ;;
                -h|--help)
                    show_help
                    exit 0
                    ;;
                *)
                    print_error "Unknown option: $1"
                    show_help
                    exit 1
                    ;;
            esac
        done
    fi
}

main "$@"
