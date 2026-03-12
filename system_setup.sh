#!/usr/bin/env bash

set -e

echo "Updating apt..."
sudo apt update

# -----------------------------
# APT PACKAGES
# -----------------------------
APT_PACKAGES=(
  build-essential
  curl
  git
  wget
  unzip
  zsh
  kitty
  stow
  rofi
  i3
  polybar
)

echo "Installing apt packages..."
for pkg in "${APT_PACKAGES[@]}"; do
  if ! dpkg -s "$pkg" >/dev/null 2>&1; then
    sudo apt install -y "$pkg"
  else
    echo "$pkg already installed"
  fi
done

# -----------------------------
# INSTALL HOMEBREW
# -----------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH
  if [[ -d /home/linuxbrew/.linuxbrew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed"
fi

# -----------------------------
# BREW PACKAGES
# -----------------------------
BREW_PACKAGES=(
  fzf
  fish
  ripgrep
  fd
  neovim
  tmux
  node
  ast-grep
  zsh-autosuggestions
  luarocks
  lazygit
  imagemagick
  tectonic
  mermaid-cli
)

echo "Installing brew packages..."
for pkg in "${BREW_PACKAGES[@]}"; do
  if ! brew list "$pkg" >/dev/null 2>&1; then
    brew install "$pkg"
  else
    echo "$pkg already installed"
  fi
done

# -----------------------------
# NPM INSTALL
# -----------------------------
echo "installing npm packages"
npm install -g typescript tailwindcss eslint prettier
echo "npm packages installed"

# -----------------------------
# INSTALL OH MY ZSH
# -----------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed"
fi

# -----------------------------
# SET ZSH AS DEFAULT SHELL
# -----------------------------
if [[ "$SHELL" != "$(which zsh)" ]]; then
  echo "Setting Zsh as default shell..."
  chsh -s "$(which zsh)"
fi

# Remap keys
setxkbmap -option caps:none
xmodmap -e "keycode 66 = F7"

# ----------------------------
# STOW DOTFILES
# ----------------------------
rm ~/.bashrc
rm ~/.zshrc
cd ~/dotfiles
stow */

echo "Stowed dotfiles"
