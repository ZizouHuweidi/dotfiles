#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

print_section() {
    echo -e "${BLUE}==>${NC} $1"
}

main() {
    echo ""
    print_section "Setting up Syncthing"
    echo ""
    
    # Check if syncthing is installed
    if ! command -v syncthing &>/dev/null; then
        print_info "Installing Syncthing..."
        sudo dnf install -y syncthing
        print_success "Syncthing installed"
    else
        print_success "Syncthing already installed"
    fi
    
    # Enable and start user service
    print_info "Enabling Syncthing user service..."
    systemctl --user enable syncthing.service
    systemctl --user start syncthing.service
    print_success "Syncthing service enabled and started"
    
    echo ""
    print_success "Syncthing setup complete!"
    print_info "Web interface available at: http://localhost:8384"
}

main
