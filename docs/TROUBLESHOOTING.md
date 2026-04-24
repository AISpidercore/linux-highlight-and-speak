# Troubleshooting Guide for Linux Highlight and Speak

This document is intended to help users troubleshoot common issues they may encounter when using the Linux Highlight and Speak application.

## Common Issues and Solutions

### 1. Text Selection Issues
**Problem:** Unable to select text from the desired application.
**Solution:** Ensure that the application you are using supports text selection. Some applications may not allow text selection due to their design. If text selection is not working, try using the keyboard shortcuts (e.g., `Ctrl + A` to select all or `Shift + Arrow Keys` to select specific sections).

### 2. Audio Playback Problems
**Problem:** The audio playback does not work or is distorted.
**Solution:** 
- Check your system's audio settings to ensure that the output device is correctly configured.
- Verify that the audio drivers are installed and up-to-date.
- Ensure that the audio output is not muted or set to a very low volume.
- Try restarting the application or your computer if the issue persists.

### 3. Piper Not Found Error
**Problem:** The error message "Piper not found" appears when launching the application.
**Solution:** 
- Ensure that Piper is installed on your system. You can install it using your distribution's package manager (e.g., `sudo apt install piper` on Ubuntu).
- If Piper is installed but still not found, check your system’s PATH variable to confirm that the correct paths are included.

### 4. Manually Testing Components
**Problem:** Need to manually test the components of Linux Highlight and Speak for debugging.
**Solution:** 
- Test the Text-to-Speech component by running the command in the terminal that simulates text input, e.g., `echo "Hello, World!" | text-to-speech-command`.
- Test the audio output by playing a test audio file using a media player.
- Ensure that all dependencies are properly installed and up-to-date. You can check for missing dependencies using `ldd` on the executable files.

## Conclusion
If you continue to experience issues after trying the above solutions, consider reaching out to the community forums or checking the official documentation for further assistance.