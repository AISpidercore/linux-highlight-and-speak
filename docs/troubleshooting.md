# Troubleshooting Guide - Linux Highlight and Speak

## Installation Issues

### "Permission denied" when running setup.sh
**Problem**: Cannot execute the setup script
**Solution**:
```bash
chmod +x setup.sh
bash setup.sh
```

### Dependencies installation fails
**Problem**: Package manager fails to install dependencies
**Solution**:
```bash
# Update package list first
sudo apt update
# Then try installation again
sudo apt install -y espeak xclip zenity
```

### "espeak: command not found"
**Problem**: Espeak is not installed
**Solution**:
```bash
# Ubuntu/Debian
sudo apt install espeak espeak-ng

# Fedora
sudo dnf install espeak espeak-ng

# Arch
sudo pacman -S espeak espeak-ng
```

### "xclip: command not found"
**Problem**: Clipboard tool not installed
**Solution**:
```bash
# Ubuntu/Debian
sudo apt install xclip

# Fedora
sudo dnf install xclip

# Arch
sudo pacman -S xclip
```

### "zenity: command not found" (GUI version)
**Problem**: GUI dialog tool not installed
**Solution**:
```bash
# Ubuntu/Debian
sudo apt install zenity

# Fedora
sudo dnf install zenity

# Arch
sudo pacman -S zenity
```

---

## Audio and Output Issues

### No sound output
**Problem**: Tool runs but no audio is heard
**Solution**:
1. Check speakers are connected and volume is up
2. Test system audio:
   ```bash
   speaker-test -t sine -f 1000 -l 1
   ```
3. Verify audio player is installed:
   ```bash
   # Install one of these
   sudo apt install pulseaudio-utils alsa-utils
   ```

### "Cannot find audio player" error
**Problem**: No compatible audio player found
**Solution**:
Install one of the supported audio players:
```bash
# PulseAudio (recommended)
sudo apt install pulseaudio-utils

# ALSA
sudo apt install alsa-utils

# FFmpeg
sudo apt install ffmpeg
```

### Audio sounds distorted or poor quality
**Problem**: Audio playback is distorted
**Solution**:
1. Check system volume level (not too high)
2. Check audio device: `pactl list sinks`
3. Try adjusting espeak parameters in the script
4. Update audio drivers if available

### Audio cuts off or stops suddenly
**Problem**: Audio playback incomplete
**Solution**:
1. Check disk space: `df -h`
2. Try shorter text passages
3. Ensure `/tmp` directory has write permissions
4. Check system resources: `free -h`

---

## Text Processing Issues

### "No text found in clipboard"
**Problem**: Tool can't read clipboard content
**Solution**:
1. Make sure you copied text: Ctrl+C
2. Verify clipboard has content:
   ```bash
   xclip -selection clipboard -o
   ```
3. Try pasting in another application to verify copy worked

### Special characters not being read
**Problem**: Some characters are skipped or mispronounced
**Solution**:
1. This is expected with some special characters
2. Try removing special characters before reading
3. Consider editing the text for clarity

### Very long text takes too long
**Problem**: Processing time is long for large texts
**Solution**:
1. Break text into smaller sections
2. This is normal - espeak processes in real-time
3. Close other applications to free resources

### Text contains formatting that sounds odd
**Problem**: Punctuation marks are being read
**Solution**:
Edit the script to filter out special characters:
```bash
# Remove punctuation before processing
text=$(echo "$text" | sed 's/[^a-zA-Z0-9 ]/ /g')
```

---

## GUI Issues

### GUI window won't open
**Problem**: GUI version doesn't launch
**Solution**:
1. Ensure zenity is installed:
   ```bash
   sudo apt install zenity
   ```
2. Use CLI version instead:
   ```bash
   highlight-and-speak
   ```
3. Check terminal for error messages:
   ```bash
   highlight-and-speak-gui 2>&1
   ```

### GUI buttons not responding
**Problem**: Dialog buttons seem frozen
**Solution**:
1. Wait a moment for processing
2. Close and reopen the dialog
3. Try CLI version
4. Check system resources: `top`

### Dialog appears in wrong location
**Problem**: Window opens off-screen
**Solution**:
This is usually a desktop environment issue. Try:
1. Move the window with keyboard (Alt+Space, then arrow keys)
2. Restart your desktop environment
3. Use CLI version instead

### Text input dialog too small
**Problem**: Cannot see all text in dialog
**Solution**:
The script sets a 500x300 window. To customize, edit the script:
```bash
zenity --text-info --editable \
    --width=800 --height=400 \  # Adjust these values
    --title="Highlight and Speak"
```

---

## Command Line Issues

### "Command not found: highlight-and-speak"
**Problem**: Symlink or PATH issue
**Solution**:
1. Verify symlink was created:
   ```bash
   which highlight-and-speak
   ls -la /usr/local/bin | grep highlight
   ```
2. If missing, create it:
   ```bash
   sudo ln -s /path/to/script /usr/local/bin/highlight-and-speak
   ```
3. Or run directly:
   ```bash
   /path/to/highlight_and_speak.sh
   ```

### Script permission errors
**Problem**: "Permission denied" when running script
**Solution**:
```bash
chmod +x highlight_and_speak.sh
chmod +x highlight_and_speak_gui.sh
```

### Script can't find dependencies
**Problem**: Script fails with dependency not found
**Solution**:
Make sure all dependencies are installed:
```bash
sudo apt install espeak xclip zenity pulseaudio-utils
```

---

## Desktop Launcher Issues

### Launcher doesn't appear in applications menu
**Problem**: Desktop entry not visible
**Solution**:
1. Verify `.desktop` file exists:
   ```bash
   ls ~/.local/share/applications/highlight-and-speak*.desktop
   ```
2. Make sure it's executable:
   ```bash
   chmod +x ~/.local/share/applications/highlight-and-speak*.desktop
   ```
3. Refresh application cache:
   ```bash
   update-desktop-database ~/.local/share/applications/
   ```

### Launcher opens but doesn't work
**Problem**: Clicking launcher does nothing
**Solution**:
1. Edit the `.desktop` file and ensure Exec path is correct:
   ```bash
   nano ~/.local/share/applications/highlight-and-speak.desktop
   # Check the Exec= line has full path
   ```
2. Verify script is executable
3. Test running from terminal directly

---

## Performance Issues

### Tool is slow to start
**Problem**: Lag before audio starts playing
**Solution**:
1. Close unnecessary applications
2. Check system resources:
   ```bash
   top
   free -h
   ```
3. Try shorter text first
4. Ensure disk has space:
   ```bash
   df -h
   ```

### High CPU usage
**Problem**: Tool uses lots of CPU
**Solution**:
This is normal during speech synthesis. However:
1. Try shorter text passages
2. Close other heavy applications
3. Check if other processes are running:
   ```bash
   top
   ```

### Disk space issues
**Problem**: Temporary files taking up space
**Solution**:
The tool cleans up temporary files. To manually clean:
```bash
rm -f /tmp/speech_gui_*.wav
rm -f /tmp/speech_*.wav
```

---

## Advanced Troubleshooting

### Check what espeak can do
```bash
# List available voices
espeak --voices

# Test basic espeak
espeak "Hello world"

# Test with specific voice
espeak -v en-us "Hello world"
```

### Debug script execution
```bash
# Run with error output
bash -x highlight_and_speak.sh 2>&1 | tee debug.log

# Check each component
xclip -selection clipboard -o  # Check clipboard
espeak -w test.wav "test"       # Check espeak
aplay test.wav                   # Check audio
```

### Check system audio setup
```bash
# List audio devices
pactl list sinks
arecord -l

# Test audio output
speaker-test -t sine -f 1000 -l 1

# Check default audio device
pactl info
```

### Monitor system resources
```bash
# Check available RAM
free -h

# Check disk space
df -h

# Check CPU usage
top -b -n 1

# Check running processes
ps aux | grep -E "(espeak|aplay|ffplay)"
```

---

## Still Having Issues?

If none of these solutions work:

1. **Collect information**:
   ```bash
   uname -a
   espeak --version
   xclip -version
   ```

2. **Create a debug log**:
   ```bash
   bash -x highlight_and_speak.sh > debug.log 2>&1
   ```

3. **Report on GitHub**:
   https://github.com/AISpidercore/linux-highlight-and-speak/issues

4. **Include**:
   - Your OS/distribution
   - Error messages from debug.log
   - What you were trying to do
   - System specifications

## Contact

- **Website**: https://www.aispidercore.com
- **GitHub Issues**: https://github.com/AISpidercore/linux-highlight-and-speak/issues
- **Espeak Support**: https://espeak.sourceforge.net/
