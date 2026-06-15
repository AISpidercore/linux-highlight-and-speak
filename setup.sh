#!/bin/bash

# Linux Highlight and Speak - Setup Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Functions for output
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Function to check the OS
check_os() {
    log_step "Checking operating system..."
    
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian|linuxmint)
                log_info "Detected: $NAME"
                ;;
            fedora)
                log_info "Detected: $NAME"
                ;;
            arch)
                log_info "Detected: $NAME"
                ;;
            *)
                log_error "Unsupported OS: $NAME"
                log_info "This tool is designed for Ubuntu, Debian, Mint, Fedora, or Arch Linux"
                exit 1
                ;;
        esac
    else
        log_error "Cannot determine OS"
        exit 1
    fi
}

# Function to install dependencies
install_dependencies() {
    log_step "Installing dependencies..."
    
    if [[ "$ID" == "ubuntu" ]] || [[ "$ID" == "debian" ]] || [[ "$ID" == "linuxmint" ]]; then
        log_info "Using apt package manager"
        sudo apt-get update
        sudo apt-get install -y git espeak espeak-ng xclip zenity pulseaudio-utils alsa-utils
    elif [[ "$ID" == "fedora" ]]; then
        log_info "Using dnf package manager"
        sudo dnf install -y git espeak espeak-ng xclip zenity pulseaudio-utils alsa-utils
    elif [[ "$ID" == "arch" ]]; then
        log_info "Using pacman package manager"
        sudo pacman -Syu --noconfirm git espeak espeak-ng xclip zenity pulseaudio
    fi
    
    log_info "Dependencies installed successfully"
}

# Function to make scripts executable
make_scripts_executable() {
    log_step "Making scripts executable..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    chmod +x "$script_dir/highlight_and_speak.sh" 2>/dev/null || true
    chmod +x "$script_dir/highlight_and_speak_gui.sh" 2>/dev/null || true
    
    log_info "Scripts are now executable"
}

# Function to create symlinks for easy access
create_symlinks() {
    log_step "Creating command shortcuts..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # CLI version
    if [ -L "/usr/local/bin/highlight-and-speak" ] || [ -f "/usr/local/bin/highlight-and-speak" ]; then
        sudo rm "/usr/local/bin/highlight-and-speak"
    fi
    sudo ln -s "$script_dir/highlight_and_speak.sh" "/usr/local/bin/highlight-and-speak"
    
    # GUI version
    if [ -L "/usr/local/bin/highlight-and-speak-gui" ] || [ -f "/usr/local/bin/highlight-and-speak-gui" ]; then
        sudo rm "/usr/local/bin/highlight-and-speak-gui"
    fi
    sudo ln -s "$script_dir/highlight_and_speak_gui.sh" "/usr/local/bin/highlight-and-speak-gui"
    
    log_info "Created commands: highlight-and-speak and highlight-and-speak-gui"
}

# Function to create desktop launchers
create_desktop_launchers() {
    log_step "Creating desktop launchers..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local apps_dir="$HOME/.local/share/applications"
    
    mkdir -p "$apps_dir"
    
    # CLI launcher
    cat > "$apps_dir/highlight-and-speak.desktop" << EOF
[Desktop Entry]
Type=Application
Name=Highlight and Speak
Comment=Convert highlighted text to speech
Exec=$script_dir/highlight_and_speak.sh
Icon=audio-volume-high
Categories=Accessibility;Utility;
Terminal=true
EOF
    
    # GUI launcher
    cat > "$apps_dir/highlight-and-speak-gui.desktop" << EOF
[Desktop Entry]
Type=Application
Name=Highlight and Speak (GUI)
Comment=Text to speech with graphical interface
Exec=$script_dir/highlight_and_speak_gui.sh
Icon=audio-volume-high
Categories=Accessibility;Utility;
Terminal=false
EOF
    
    chmod +x "$apps_dir/highlight-and-speak.desktop"
    chmod +x "$apps_dir/highlight-and-speak-gui.desktop"
    
    log_info "Desktop launchers created"
}

# Function to display post-installation instructions
post_install_info() {
    echo ""
    echo -e "${GREEN}================================================${NC}"
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo -e "${GREEN}================================================${NC}"
    echo ""
    log_info "CLI Version - Usage:"
    echo "  Highlight some text, then run:"
    echo "    highlight-and-speak"
    echo ""
    log_info "GUI Version - Usage:"
    echo "  Run the GUI version:"
    echo "    highlight-and-speak-gui"
    echo ""
    log_info "For more information, visit: https://www.aispidercore.com"
    echo ""
}

# Main script execution
main() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    log_info "Starting Linux Highlight and Speak setup..."
    echo ""
    
    check_os
    install_dependencies
    make_scripts_executable
    create_symlinks
    create_desktop_launchers
    
    post_install_info
}

# Run main function
main "$@"
