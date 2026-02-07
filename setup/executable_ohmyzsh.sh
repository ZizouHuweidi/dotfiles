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
    print_section "Installing Oh-My-Zsh"
    echo ""
    
    # Check if oh-my-zsh is already installed
    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_success "Oh-My-Zsh already installed"
        print_info "If you want to reinstall, remove ~/.oh-my-zsh first"
        exit 0
    fi
    
    # Install zsh if not present
    if ! command -v zsh &>/dev/null; then
        print_info "Installing zsh..."
        sudo dnf install -y zsh
        print_success "zsh installed"
    else
        print_success "zsh already installed"
    fi
    
    # Install Oh-My-Zsh
    print_info "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh-My-Zsh installed"
    
    # Change default shell to zsh
    if [ "$SHELL" != "$(which zsh)" ]; then
        print_info "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh"
        print_info "You will need to log out and back in for the change to take effect"
    else
        print_success "zsh is already the default shell"
    fi
    
    echo ""
    print_success "Oh-My-Zsh installation complete!"
    print_info "Plugins and themes can be configured in ~/.zshrc"
    print_info "Run 'source ~/.zshrc' or log out and back in to start using zsh"
}

main
