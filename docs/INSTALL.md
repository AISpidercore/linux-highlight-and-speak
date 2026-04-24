# Installation Instructions for linux-highlight-and-speak

## Dependencies
Before you start, make sure you have the following dependencies installed on your Linux system:

1. **Python 3**: 
   - Install via package manager (e.g., `sudo apt install python3` for Debian/Ubuntu).

2. **Pip**: 
   - Install Python package manager (e.g., `sudo apt install python3-pip`).

3. **Required Python Packages**:
   - Install the necessary Python packages by running:
     ```bash
     pip install pyttsx3 pyaudio
     ```

4. **GTK and GDK**: 
   - If not already installed, these libraries can be installed via:
     ```bash
     sudo apt install libgtk-3-dev libgdk-pixbuf2.0-dev
     ```

## Setting Up Piper TTS
1. **Clone the Piper Repository**:
   Run the following command to clone the Piper repository from GitHub:
   ```bash
   git clone https://github.com/errantpioneer/piper
   cd piper
   ```

2. **Install Piper**: 
   Install Piper by following the instructions in the repository documentation. This may include compiling the code and configuring necessary settings.

3. **Download Voice Models**:
   To download the voice models for Piper, execute the following command within the Piper directory:
   ```bash
   ./download_voicers.sh
   ```

   Ensure sufficient disk space is available as the models can be large.

## Desktop Launcher Configuration
1. **Create Desktop Entry**:
   Create a desktop launcher entry so that you can easily access the application from your desktop environment:
   - Create a file named `highlight-and-speak.desktop` in `~/.local/share/applications/`:
     ```bash
     touch ~/.local/share/applications/highlight-and-speak.desktop
     ```
   - Open this file in a text editor and add the following content:
     ```ini
     [Desktop Entry]
     Name=Highlight and Speak
     Exec=python3 /path/to/linux-highlight-and-speak/main.py
     Icon=/path/to/icon.png
     Type=Application
     Terminal=false
     Categories=Utility;
     ```
   Replace `/path/to/linux-highlight-and-speak/main.py` and `/path/to/icon.png` with the actual paths to the application script and icon respectively.

2. **Make the Launcher Executable**:
   Run the following command to ensure that the desktop entry is executable:
   ```bash
   chmod +x ~/.local/share/applications/highlight-and-speak.desktop
   ```

## Running the Application
Now, you can search for "Highlight and Speak" in your applications menu and launch the program. Ensure that your microphone and speakers are properly configured before using it.

For any troubleshooting or issues, refer to the documentation provided in the repository or seek help in forums relevant to the project.