#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

FONTS_DIR="$HOME/.local/share/fonts"
NERD_FONTS_VERSION="3.2.1"

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

# Create fonts directory
setup_fonts_dir() {
    if [ ! -d "$FONTS_DIR" ]; then
        print_info "Creating fonts directory..."
        mkdir -p "$FONTS_DIR"
        print_success "Fonts directory created"
    else
        print_success "Fonts directory already exists"
    fi
}

# Download and install Nerd Font
download_nerd_font() {
    local font_name=$1
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONTS_VERSION}/${font_name}.zip"
    local temp_dir=$(mktemp -d)
    local font_dir="$FONTS_DIR/$font_name"
    
    if [ -d "$font_dir" ]; then
        print_success "$font_name already installed"
        rm -rf "$temp_dir"
        return 0
    fi
    
    print_info "Downloading $font_name..."
    
    if curl -L -o "$temp_dir/${font_name}.zip" "$font_url" 2>/dev/null; then
        mkdir -p "$font_dir"
        unzip -q "$temp_dir/${font_name}.zip" -d "$font_dir"
        rm -f "$font_dir"/*Windows* "$font_dir"/*"Windows Compatible"* 2>/dev/null || true
        print_success "$font_name installed"
    else
        print_error "Failed to download $font_name"
        rm -rf "$temp_dir"
        return 1
    fi
    
    rm -rf "$temp_dir"
}

# Update font cache
update_font_cache() {
    print_info "Updating font cache..."
    fc-cache -fv "$FONTS_DIR" >/dev/null 2>&1
    print_success "Font cache updated"
}

main() {
    echo ""
    print_section "Installing Nerd Fonts"
    echo ""
    
    setup_fonts_dir
    
    # Fonts to install
    local fonts=(
        "JetBrainsMono"
        "FiraCode"
        "Hack"
        "Terminus"
    )
    
    print_info "Installing fonts: ${fonts[*]}"
    echo ""
    
    for font in "${fonts[@]}"; do
        download_nerd_font "$font"
    done
    
    update_font_cache
    
    echo ""
    print_success "All fonts installed successfully!"
    print_info "Fonts installed to: $FONTS_DIR"
}

main
