# Linux Highlight and Speak

## Overview
Linux Highlight and Speak is an innovative tool designed to enhance accessibility and usability for users by converting highlighted text into speech. It allows users to select any text on their Linux systems and have it read aloud, facilitating easier reading and comprehension, especially for visually impaired individuals.

## Quick Start Instructions
1. **Installation**: Clone the repository to your local machine using:
   ```bash
   git clone https://github.com/<owner>/linux-highlight-and-speak.git
   ```
   Replace `<owner>` with the respective GitHub username or organization name.

2. **Dependencies**: Ensure you have the following dependencies installed:
   - `espeak` or any other text-to-speech engine
   - `xclip` for clipboard operations

   You can install them using:
   ```bash
   sudo apt install espeak xclip
   ```

3. **Usage**: To highlight text and convert it to speech, use the command:
   ```bash
   ./highlight_and_speak.sh
   ```
   Simply select the text you want to hear, and the tool will read it to you.

4. **Usage with GUI**: If you prefer a graphical interface, you can install and run the GUI version using:
   ```bash
   ./highlight_and_speak_gui.sh
   ```

## Documentation
For more detailed information about the features, usage, and configuration, please visit the following documentation files:
- [User Guide](docs/user-guide.md)
- [Installation Instructions](docs/installation.md)
- [FAQ](docs/faq.md)
- [Troubleshooting](docs/troubleshooting.md)

## Contributing
We welcome contributions! Please see our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.