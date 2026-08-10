#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

require_supported_os

if have zsh; then
    echo "zsh already installed: $(zsh --version)"
elif [ "$OS" = "linux" ]; then
    echo "Installing zsh..."
    sudo apt-get update -y && sudo apt-get install -y zsh
    echo "zsh installed: $(zsh --version)"
else
    # macOS ships zsh since Catalina, so getting here means something is off
    die "zsh not found. Install it with Homebrew (brew install zsh) and re-run."
fi

ZSH_BIN="$(command -v zsh)"

if [ "${SHELL:-}" = "$ZSH_BIN" ]; then
    echo "zsh already the default shell"
    exit 0
fi

# chsh only accepts shells listed in /etc/shells
if ! grep -qxF "$ZSH_BIN" /etc/shells 2>/dev/null; then
    echo "Adding $ZSH_BIN to /etc/shells..."
    echo "$ZSH_BIN" | sudo tee -a /etc/shells >/dev/null
fi

echo "Changing default shell to zsh..."
chsh -s "$ZSH_BIN"
