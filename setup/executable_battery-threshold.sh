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
    print_section "Setting up ThinkPad Battery Threshold"
    echo ""
    
    # Check if this is a ThinkPad with battery support
    if [ ! -d "/sys/class/power_supply/BAT0" ]; then
        print_error "No battery found at /sys/class/power_supply/BAT0"
        print_info "This script is designed for ThinkPad laptops with BAT0"
        exit 1
    fi
    
    # Set battery thresholds
    # Start charging at 60%, stop at 80%
    START_THRESHOLD=60
    STOP_THRESHOLD=80
    
    print_info "Setting battery start threshold to ${START_THRESHOLD}%"
    if echo "$START_THRESHOLD" | sudo tee /sys/class/power_supply/BAT0/charge_start_threshold &>/dev/null; then
        print_success "Start threshold set to ${START_THRESHOLD}%"
    else
        print_error "Failed to set start threshold (may require kernel module or different path)"
    fi
    
    print_info "Setting battery stop threshold to ${STOP_THRESHOLD}%"
    if echo "$STOP_THRESHOLD" | sudo tee /sys/class/power_supply/BAT0/charge_stop_threshold &>/dev/null; then
        print_success "Stop threshold set to ${STOP_THRESHOLD}%"
    else
        print_error "Failed to set stop threshold (may require kernel module or different path)"
    fi
    
    # Try to make settings persistent via tp_smapi or acpi_call
    print_info "Attempting to make settings persistent..."
    
    # Check for tp_smapi
    if [ -d "/sys/devices/platform/smapi" ]; then
        print_success "tp_smapi detected, settings should persist"
    else
        print_info "tp_smapi not detected"
        print_info "You may need to install tp_smapi kernel module for persistent settings"
    fi
    
    echo ""
    print_success "Battery threshold configuration complete!"
    print_info "Current settings:"
    echo "  Start charging at: ${START_THRESHOLD}%"
    echo "  Stop charging at: ${STOP_THRESHOLD}%"
}

main
