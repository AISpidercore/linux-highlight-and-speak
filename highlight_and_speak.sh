#!/bin/bash

# Linux Highlight and Speak - Main Script
# Convert highlighted text to speech using espeak

set -e

# Configuration
TEMP_FILE="/tmp/highlight_to_speech_$$.txt"

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
    
    for cmd in espeak xclip; do
        if ! command -v $cmd &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        log_info "Install with: sudo apt install -y ${missing_deps[*]}"
        exit 1
    fi
}

# Function to get highlighted text from clipboard
get_highlighted_text() {
    # Get text from clipboard
    if command -v xclip &> /dev/null; then
        xclip -selection clipboard -o > "$TEMP_FILE" 2>/dev/null || true
    elif command -v xsel &> /dev/null; then
        xsel --clipboard --output > "$TEMP_FILE" 2>/dev/null || true
    else
        log_error "No clipboard manager found"
        exit 1
    fi
    
    if [ ! -s "$TEMP_FILE" ]; then
        log_error "No text found in clipboard. Please highlight some text first."
        exit 1
    fi
}

# Function to convert text to speech
text_to_speech() {
    local text="$1"
    local output_file="$2"
    
    log_info "Converting text to speech..."
    
    # Use espeak to convert text to WAV
    espeak -w "$output_file" "$text" 2>/dev/null || {
        log_error "Failed to convert text to speech"
        exit 1
    }
    
    log_info "Text converted successfully"
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
        log_error "No audio player found"
        exit 1
    fi
}

# Function to cleanup temporary files
cleanup() {
    rm -f "$TEMP_FILE"
    rm -f "/tmp/speech_$$.wav"
}

# Main execution
main() {
    log_info "Starting Highlight and Speak..."
    
    check_dependencies
    get_highlighted_text
    
    local text=$(cat "$TEMP_FILE")
    local output_file="/tmp/speech_$$.wav"
    
    text_to_speech "$text" "$output_file"
    play_audio "$output_file"
    
    log_info "Speech playback complete!"
}

# Trap to cleanup on exit
trap cleanup EXIT

# Run main function
main
