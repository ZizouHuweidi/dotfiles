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

# Add repositories
setup_repositories() {
  print_section "Setting up repositories"

  # Add Terra repository
  if ! rpm -q terra-release &>/dev/null; then
    print_info "Adding Terra repository..."
    sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release -y
    print_success "Terra repository added"
  else
    print_success "Terra repository already configured"
  fi

  # Add Google Chrome repository
  if [ ! -f /etc/yum.repos.d/google-chrome.repo ]; then
    print_info "Adding Google Chrome repository..."
    sudo tee /etc/yum.repos.d/google-chrome.repo <<EOF
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
    print_success "Google Chrome repository added"
  else
    print_success "Google Chrome repository already configured"
  fi

  # Add Flathub
  if ! flatpak remote-list | grep -q flathub; then
    print_info "Adding Flathub repository..."
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    print_success "Flathub repository added"
  else
    print_success "Flathub repository already configured"
  fi
}

# Install DNF packages
install_dnf_packages() {
  print_section "Installing DNF packages"

  # Core system and file management
  local system_packages=(
    chezmoi
    gdu
    htop
    yazi
    zathura
    zathura-pdf-mupdf
    lazygit
  )

  # Terminal tools
  local terminal_packages=(
    ghostty
    bat
    fzf
    ripgrep
    fd
    starship
    tldr
    zoxide
    lsd
  )

  # Media and utility tools
  local media_packages=(
    transmission-gtk
    transmission-cli
    yt-dlp
    fastfetch
    android-file-transfer
  )

  # Development tools
  local dev_packages=(
    docker
    docker-compose
    golang
    rustup
    bun
    uv
    zed
    codium
    codium-marketplace
    nvm
    neovim
    google-chrome-stable
  )

  # System utilities
  local sys_packages=(
    net-tools
    ntfs-3g
    zsh-autosuggestions
    zsh-syntax-highlighting
  )

  print_info "Updating package cache..."
  sudo dnf makecache

  print_info "Installing packages..."
  sudo dnf install -y \
    "${system_packages[@]}" \
    "${terminal_packages[@]}" \
    "${media_packages[@]}" \
    "${dev_packages[@]}" \
    "${sys_packages[@]}"

  print_success "DNF packages installed"
}

# Install tools not in standard repos
install_additional_tools() {
  print_section "Installing additional tools"
}

# Install Flatpak applications
install_flatpaks() {
  print_section "Installing Flatpak applications"

  local flatpaks=(
    "md.obsidian.Obsidian"
    "org.telegram.desktop"
    "com.calibre_ebook.calibre"
    "com.rtosta.zapzap"
  )

  for app in "${flatpaks[@]}"; do
    if ! flatpak list --app | grep -q "$app"; then
      print_info "Installing $app..."
      flatpak install -y flathub "$app"
      print_success "$app installed"
    else
      print_success "$app already installed"
    fi
  done
}

# Enable services
enable_services() {
  print_section "Enabling services"

  print_info "Enabling Docker service..."
  sudo systemctl enable --now docker
  print_success "Docker service enabled"
}

main() {
  echo ""
  print_section "Starting package installation"
  echo ""

  setup_repositories
  install_dnf_packages
  install_additional_tools
  install_flatpaks
  enable_services

  echo ""
  print_success "All packages installed successfully!"
  echo ""
  print_info "Note: You may need to log out and back in for some changes to take effect."
}

main
