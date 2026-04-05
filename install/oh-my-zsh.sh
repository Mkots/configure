#!/usr/bin/env bash
set -euo pipefail

if [ -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
    echo "oh-my-zsh already installed at ${ZSH:-$HOME/.oh-my-zsh}"
    exit 0
fi

if ! command -v zsh &>/dev/null; then
    echo "Error: zsh is required. Run install/zsh.sh first." >&2
    exit 1
fi

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "oh-my-zsh installed at ${ZSH:-$HOME/.oh-my-zsh}"
