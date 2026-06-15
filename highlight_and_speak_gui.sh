#!/bin/bash

# Linux Highlight and Speak - GUI Version
# Simple graphical interface for text-to-speech using zenity

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to log messages
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check dependencies
check_dependencies() {
    local missing_deps=()
    
    for cmd in espeak xclip zenity; do
        if ! command -v $cmd &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        zenity --error --text "Install missing packages:\nsudo apt install -y ${missing_deps[*]}" 2>/dev/null || true
        exit 1
    fi
}

# Function to show text input dialog
get_text_from_dialog() {
    local text=$(zenity --text-info --editable --title="Highlight and Speak" \
        --window-icon=text-editor --width=500 --height=300 2>/dev/null)
    
    if [ -z "$text" ]; then
        exit 0
    fi
    
    echo "$text"
}

# Function to get text from clipboard
get_text_from_clipboard() {
    xclip -selection clipboard -o 2>/dev/null || echo ""
}

# Function to convert text to speech
text_to_speech() {
    local text="$1"
    local output_file="/tmp/speech_gui_$$.wav"
    
    log_info "Converting text to speech..."
    
    # Use espeak to convert text to WAV
    espeak -w "$output_file" "$text" 2>/dev/null || {
        zenity --error --text "Failed to convert text to speech" 2>/dev/null || true
        return 1
    }
    
    log_info "Text converted successfully"
    echo "$output_file"
}

# Function to play audio
play_audio() {
    local audio_file="$1"
    
    log_info "Playing audio..."
    
    # Try different audio players
    if command -v paplay &> /dev/null; then
        paplay "$audio_file" 2>/dev/null
    elif command -v aplay &> /dev/null; then
        aplay "$audio_file" 2>/dev/null
    elif command -v ffplay &> /dev/null; then
        ffplay -autoexit -nodisp "$audio_file" 2>/dev/null
    else
        zenity --error --text "No audio player found" 2>/dev/null || true
        return 1
    fi
    
    rm -f "$audio_file"
}

# Main execution with user choice
main() {
    check_dependencies
    
    # Ask user where to get text from
    local choice=$(zenity --list --title="Highlight and Speak" \
        --text="Where is your text?" \
        --column="Option" \
        "From clipboard (just paste)" \
        "Type in dialog box" \
        "Cancel" 2>/dev/null)
    
    case "$choice" in
        "From clipboard (just paste)")
            local text=$(get_text_from_clipboard)
            if [ -z "$text" ]; then
                zenity --error --text "No text found in clipboard" 2>/dev/null || true
                exit 1
            fi
            ;;
        "Type in dialog box")
            text=$(get_text_from_dialog)
            ;;
        *)
            exit 0
            ;;
    esac
    
    # Convert and play
    local audio_file=$(text_to_speech "$text") || exit 1
    play_audio "$audio_file"
    
    zenity --info --text "Speech playback complete!" 2>/dev/null || true
}

# Run main function
main
