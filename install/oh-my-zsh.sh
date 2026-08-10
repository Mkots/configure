#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

if [ -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
    echo "oh-my-zsh already installed at ${ZSH:-$HOME/.oh-my-zsh}"
    exit 0
fi

have zsh || die "zsh is required. Run install/zsh.sh first."

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "oh-my-zsh installed at ${ZSH:-$HOME/.oh-my-zsh}"
