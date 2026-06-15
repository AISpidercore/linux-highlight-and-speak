# Contributing to Linux Highlight and Speak

Thank you for your interest in contributing! This guide will help you get started.

## Code of Conduct

Be respectful, inclusive, and constructive in all interactions.

## How to Contribute

### Reporting Bugs

**Before creating an issue, please check:**
- Existing issues don't already report the same bug
- You're using the latest version
- You've followed the troubleshooting guide

**When reporting, include:**
- Your OS and distribution
- Steps to reproduce the bug
- Expected behavior vs actual behavior
- Error messages or logs
- System specifications (RAM, CPU)

### Suggesting Enhancements

**Good enhancement ideas include:**
- New voice/TTS options
- Performance improvements
- Better error handling
- Additional language support
- GUI improvements
- Documentation improvements

**When suggesting, include:**
- Use case description
- Why this would be valuable
- Possible implementation ideas

### Submitting Code Changes

1. **Fork the repository**
2. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**:
   - Keep commits atomic and descriptive
   - Follow the existing code style
   - Add comments for complex logic
4. **Test thoroughly**:
   - Test on your system
   - Try edge cases
   - Verify error handling
5. **Submit a pull request**:
   - Describe what you changed and why
   - Reference any related issues
   - Be open to feedback

### Documentation Improvements

- Spelling and grammar fixes
- Clearer explanations
- Additional examples
- Better organization

## Development Setup

### Clone the Repository

```bash
git clone https://github.com/AISpidercore/linux-highlight-and-speak.git
cd linux-highlight-and-speak
```

### Install Development Dependencies

```bash
sudo apt install git espeak xclip zenity
# For testing
sudo apt install shellcheck
```

### Testing Your Changes

```bash
# Check shell script syntax
shellcheck highlight_and_speak.sh

# Test the CLI version
./highlight_and_speak.sh

# Test the GUI version
./highlight_and_speak_gui.sh

# Test the setup script
bash setup.sh
```

## Project Structure

```
linux-highlight-and-speak/
├── highlight_and_speak.sh          # CLI version
├── highlight_and_speak_gui.sh       # GUI version
├── setup.sh                         # Installation script
├── LICENSE                          # MIT License
├── README.md                        # Main documentation
├── docs/
│   ├── installation.md              # Installation guide
│   ├── user-guide.md                # Usage guide
│   ├── faq.md                       # Frequently asked questions
│   └── troubleshooting.md           # Troubleshooting guide
└── CONTRIBUTING.md                  # This file
```

## Code Style Guidelines

### Bash Scripts

```bash
# Use meaningful variable names
TEMP_FILE="/tmp/highlight_to_speech_$$.txt"

# Use functions for reusable code
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

# Add comments for complex logic
# Check if file exists before processing
if [ -f "$FILE" ]; then
    # Process file
fi

# Use set -e for error handling
set -e

# Quote variables to avoid word splitting
"$variable"

# Use [[ ]] for conditionals (when possible)
if [[ "$string" == "value" ]]; then
    # ...
fi
```

## Common Tasks

### Adding a New Feature

1. Create a feature branch
2. Modify the appropriate script
3. Test thoroughly
4. Update documentation
5. Submit a pull request

### Fixing a Bug

1. Create a bug fix branch
2. Locate and fix the issue
3. Add a test case if possible
4. Update CHANGELOG if one exists
5. Submit a pull request

### Improving Documentation

1. Create a documentation branch
2. Edit the relevant file
3. Check for clarity and accuracy
4. Submit a pull request

## Pull Request Process

1. **Before submitting**:
   - Test your changes
   - Check for obvious issues
   - Update relevant documentation

2. **In your PR description**:
   - Clearly describe changes
   - Reference related issues
   - Explain reasoning if non-obvious

3. **Respond to feedback**:
   - Be open to suggestions
   - Make requested changes
   - Ask for clarification if needed

4. **Merge**:
   - Maintainers will merge when ready
   - Thank you for contributing!

## Areas for Contribution

### High Priority
- Bug fixes
- Performance improvements
- Better error messages
- Documentation improvements

### Medium Priority
- Code refactoring
- Test improvements
- Security enhancements

### Lower Priority
- New features (discuss first)
- Language additions
- New voice options

## Recognition

Contributors will be:
- Listed in README (with permission)
- Credited in commit messages
- Thanked in release notes

## Questions?

- **GitHub Issues**: Ask in relevant issue discussions
- **GitHub Discussions**: Create a discussion thread
- **Website**: https://www.aispidercore.com

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to make Linux Highlight and Speak better!**
