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

configure_dnf() {
  print_section "Configuring DNF"

  local dnf_conf="/etc/dnf/dnf.conf"

  if [ ! -f "$dnf_conf" ]; then
    print_info "Creating $dnf_conf..."
    sudo tee "$dnf_conf" <<EOF
[main]
install_weak_deps=False
EOF
    print_success "DNF config created with install_weak_deps=False"
    return 0
  fi

  if grep -q "install_weak_deps" "$dnf_conf"; then
    if grep -q "^install_weak_deps=False" "$dnf_conf"; then
      print_success "install_weak_deps=False already configured"
      return 0
    else
      print_info "Updating install_weak_deps in $dnf_conf..."
      sudo sed -i 's/^install_weak_deps=.*/install_weak_deps=False/' "$dnf_conf"
      print_success "install_weak_deps updated to False"
      return 0
    fi
  fi

  if grep -q "^\[main\]" "$dnf_conf"; then
    print_info "Adding install_weak_deps=False to [main] section..."
    sudo sed -i '/^\[main\]/a install_weak_deps=False' "$dnf_conf"
    print_success "install_weak_deps=False added to [main] section"
  else
    print_info "Adding [main] section with install_weak_deps=False..."
    sudo sed -i '1i\[main\]' "$dnf_conf"
    sudo sed -i '2iinstall_weak_deps=False' "$dnf_conf"
    print_success "[main] section with install_weak_deps=False added"
  fi
}

main() {
  echo ""
  print_section "Starting DNF configuration"
  echo ""

  configure_dnf

  echo ""
  print_success "DNF configuration completed!"
  echo ""
}

main
