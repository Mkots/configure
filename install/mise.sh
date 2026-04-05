#!/usr/bin/env bash
set -euo pipefail

if command -v mise &>/dev/null; then
    echo "mise already installed: $(mise --version)"
    exit 0
fi

echo "Installing mise..."
curl -sSf https://mise.run | sh

MISE_BIN="$HOME/.local/bin/mise"

if ! grep -q 'mise activate' "${ZDOTDIR:-$HOME}/.zshrc" 2>/dev/null; then
    echo 'eval "$($HOME/.local/bin/mise activate zsh)"' >> "${ZDOTDIR:-$HOME}/.zshrc"
fi

echo "mise installed: $("$MISE_BIN" --version)"
