# Linux Highlight and Speak

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status: Active](https://img.shields.io/badge/Status-Active-brightgreen)]()

**Website:** [www.aispidercore.com](https://www.aispidercore.com)

## Overview

Linux Highlight and Speak is an innovative accessibility tool designed to convert any highlighted text into natural-sounding speech. Simply select, copy, and listen. Fully offline and privacy-focused.

## Features

- 🔊 Convert highlighted text to speech instantly
- 💬 Support for multiple voices and languages (via espeak)
- 🖥️ Both CLI and GUI interfaces available
- 🔒 Completely offline - no cloud dependencies
- ♿ Enhanced accessibility for users with visual impairments
- 📋 Works with any text editor, web browser, or document
- ⚡ Lightweight and responsive

## Quick Start

### 1. Installation

Clone the repository to your local machine:
```bash
git clone https://github.com/AISpidercore/linux-highlight-and-speak.git
cd linux-highlight-and-speak
```

### 2. Automated Setup (Recommended)

Run the setup script:
```bash
bash setup.sh
```

This will install all dependencies and create convenient shortcuts.

### 3. Manual Setup (Alternative)

Install dependencies:
```bash
# Ubuntu/Debian
sudo apt install espeak xclip zenity

# Fedora
sudo dnf install espeak xclip zenity

# Arch
sudo pacman -S espeak xclip zenity
```

Make scripts executable:
```bash
chmod +x highlight_and_speak.sh highlight_and_speak_gui.sh
```

### 4. Usage

**CLI Version** (Command Line):
```bash
# Highlight text, copy it (Ctrl+C), then run:
highlight-and-speak
```

**GUI Version** (Graphical Interface):
```bash
highlight-and-speak-gui
```

## Documentation

For detailed information, please visit:
- [Installation Guide](docs/installation.md) - Complete setup instructions
- [User Guide](docs/user-guide.md) - How to use the tool
- [FAQ](docs/faq.md) - Frequently asked questions
- [Troubleshooting](docs/troubleshooting.md) - Solutions to common issues

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## About

Developed by **AISpidercore**  
Website: [www.aispidercore.com](https://www.aispidercore.com)

## Support

If you encounter issues or have questions:
- 📖 Check the [Troubleshooting Guide](docs/troubleshooting.md)
- ❓ See the [FAQ](docs/faq.md)
- 🐛 Report bugs on [GitHub Issues](https://github.com/AISpidercore/linux-highlight-and-speak/issues)
- 💬 Visit our [Website](https://www.aispidercore.com)
