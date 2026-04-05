#!/usr/bin/env bash
set -euo pipefail

if command -v zsh &>/dev/null; then
    echo "zsh already installed: $(zsh --version)"
    exit 0
fi

echo "Installing zsh..."
sudo apt-get update -y && sudo apt-get install -y zsh

echo "zsh installed: $(zsh --version)"

if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(command -v zsh)"
fi
