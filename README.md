# My MacOS Configuration Setup
All the cool kids have their own configs :DD

## Xcode Command Line Tools

```bash
xcode-select --install # install

# Re-install method just in case
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

## Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## System Settings

```applescript
# Enable full keyboard access for all controls
defaults write -g AppleKeyboardUIMode -int 3
```

VSCode Vim Plugin Enable key-reapting

```bash
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# If necessary, reset global default
defaults delete -g ApplePressAndHoldEnabled
```

### Fonts

```bash
brew install --cask font-fira-code
brew install --cask font-hack-nerd-font
```

## Development

```bash
brew install tree
```

## SSH Configuration

## GUI Apps

```bash
# Terminal
brew install --cask kitty

# Mac App Store Manager
brew install mas

# Browser
brew install --cask google-chrome

# Filesync
mas install 823766827

# Screen Recording
brew install --cask obs

# WeChat
mas install 836500024
```
