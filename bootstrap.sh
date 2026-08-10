#!/usr/bin/env bash
set -euo pipefail

REPO="${DOTFILES_REPO:-mkots/configure}"
BIN_DIR="$HOME/.local/bin"

if ! command -v chezmoi &>/dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
    export PATH="$BIN_DIR:$PATH"
fi

echo "Running chezmoi init --apply $REPO..."
chezmoi init --apply "$REPO"

echo ""
echo "Bootstrap complete. Restart your shell or run: exec zsh"
