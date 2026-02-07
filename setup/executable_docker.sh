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
    print_section "Setting up Docker"
    echo ""
    
    # Check if docker is installed
    if ! command -v docker &>/dev/null; then
        print_error "Docker not found. Please run packages.sh first."
        exit 1
    fi
    
    # Enable Docker service
    print_info "Enabling Docker service..."
    sudo systemctl enable --now docker
    print_success "Docker service enabled"
    
    # Add current user to docker group
    if ! groups "$USER" | grep -q "\bdocker\b"; then
        print_info "Adding user to docker group..."
        sudo usermod -aG docker "$USER"
        print_success "User added to docker group"
        print_info "You will need to log out and back in for group changes to take effect"
    else
        print_success "User already in docker group"
    fi
    
    # Test Docker installation
    print_info "Testing Docker installation..."
    if docker --version &>/dev/null; then
        print_success "Docker installed: $(docker --version)"
    else
        print_error "Docker test failed"
    fi
    
    echo ""
    print_success "Docker setup complete!"
    print_info "Run 'docker run hello-world' after logging back in to test"
}

main
