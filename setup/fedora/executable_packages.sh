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

  # Add RPM Fusion Free and Non-Free repositories
  if ! rpm -q rpmfusion-free-release &>/dev/null; then
    print_info "Adding RPM Fusion repositories..."
    sudo dnf install -y \
      "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
      "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
    print_success "RPM Fusion repositories added"
  else
    print_success "RPM Fusion repositories already configured"
  fi

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
    gh
  )

  # Media and utility tools
  local media_packages=(
    transmission-gtk
    transmission-cli
    yt-dlp
    fastfetch
    cmus
    android-file-transfer
    ffmpeg
    gstreamer1-plugins-base
    gstreamer1-plugins-good
    gstreamer1-plugins-ugly
    gstreamer1-plugins-bad-free
    gstreamer1-plugins-bad-freeworld
    gstreamer1-libav
    ffmpeg-libs
    libva
    libva-utils
    openh264
    gstreamer1-plugin-openh264
    mozilla-openh264
  )

  # Development tools
  local dev_packages=(
    docker
    docker-compose
    golang
    rustup
    bun
    deno
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
    unzip
    p7zip
    p7zip-plugins
    unrar
    fuse-libs
    intel-media-driver
    libva-intel-driver
    mesa-va-drivers
    jq
  )

  # Sway-specific packages
  local sway_packages=(
    dunst
    thunar
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-volman
    brightnessctl
    pulseaudio-utils
    libnotify
    playerctl
    lxqt-policykit
    wl-clipboard
    slurp
    grim
    swappy
    gammastep
    gammastep-indicator
    mpris-proxy
    wl-mirror
    wlogout
    wdisplays
    power-profiles-daemon
    nwg-look
    rofi
    rofimoji
  )

  print_info "Updating package cache..."
  sudo dnf makecache

  print_info "Upgrading core group..."
  sudo dnf group upgrade -y core
  sudo dnf4 group install -y core

  print_info "Enabling Cisco OpenH264 repository..."
  sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

  print_info "Swapping ffmpeg-free for full ffmpeg..."
  sudo dnf swap -y 'ffmpeg-free' 'ffmpeg' --allowerasing || true

  print_info "Installing packages..."
  sudo dnf install -y \
    "${system_packages[@]}" \
    "${terminal_packages[@]}" \
    "${media_packages[@]}" \
    "${dev_packages[@]}" \
    "${sys_packages[@]}" \
    "${sway_packages[@]}"

  print_info "Installing multimedia codecs group..."
  sudo dnf4 group install -y multimedia || true
  sudo dnf upgrade -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin || true
  sudo dnf group install -y sound-and-video || true

  print_success "DNF packages installed"
}

# Install tools not in standard repos
install_additional_tools() {
  print_section "Installing additional tools"

  # Install Gruvbox GTK Theme
  install_gruvbox_gtk_theme
}

# Install Gruvbox GTK Theme
install_gruvbox_gtk_theme() {
  print_section "Installing Gruvbox GTK Theme"

  # Install required dependencies for building themes
  print_info "Installing theme build dependencies..."
  sudo dnf install -y sassc gtk-murrine-engine || true

  # Clone and install Gruvbox theme if not already installed
  if [ ! -d "$HOME/.themes/Gruvbox" ]; then
    print_info "Cloning Gruvbox GTK theme..."
    local temp_dir=$(mktemp -d)
    cd "$temp_dir"

    git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git || {
      print_error "Failed to clone Gruvbox theme"
      cd -
      rm -rf "$temp_dir"
      return 1
    }

    cd Gruvbox-GTK-Theme/themes

    print_info "Installing Gruvbox theme (dark variant with green accent)..."
    ./install.sh -t green -c dark -l || {
      print_error "Failed to install Gruvbox theme"
      cd -
      rm -rf "$temp_dir"
      return 1
    }

    cd -
    rm -rf "$temp_dir"

    print_success "Gruvbox GTK theme installed"
  else
    print_success "Gruvbox GTK theme already installed"
  fi

  # Configure Flatpak to use custom themes
  print_info "Configuring Flatpak theme support..."
  sudo flatpak override --filesystem=$HOME/.themes || true
  sudo flatpak override --filesystem=$HOME/.icons || true
  flatpak override --user --filesystem=xdg-config/gtk-4.0 || true
  sudo flatpak override --filesystem=xdg-config/gtk-4.0 || true

  print_success "Gruvbox GTK theme setup complete"
}

# Install Flatpak applications
install_flatpaks() {
  print_section "Installing Flatpak applications"

  local flatpaks=(
    "md.obsidian.Obsidian"
    "org.telegram.desktop"
    "com.calibre_ebook.calibre"
    "com.rtosta.zapzap"
    "com.github.tchx84.Flatseal"
    "it.mijorus.gearlever"
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

  # Enable theme support for Flatpaks
  print_info "Enabling Flatpak theme support..."
  sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
  sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
  sudo flatpak override --filesystem=$HOME/.themes
  sudo flatpak override --filesystem=$HOME/.icons
}

# Enable services
enable_services() {
  print_section "Enabling services"

  print_info "Enabling Docker service..."
  sudo systemctl enable --now docker
  print_success "Docker service enabled"
}

# Update firmware
update_firmware() {
  print_section "Checking for firmware updates"

  print_info "Refreshing firmware metadata..."
  sudo fwupdmgr refresh --force || true

  print_info "Checking for available firmware updates..."
  sudo fwupdmgr get-updates || true

  print_info "Applying firmware updates (if any)..."
  sudo fwupdmgr update || true

  print_success "Firmware update check completed"
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
  update_firmware

  echo ""
  print_success "All packages installed successfully!"
  echo ""
  print_info "Note: You may need to log out and back in for some changes to take effect."
  print_info "For OpenH264 in Firefox, enable the plugin in Firefox settings."
}

main
