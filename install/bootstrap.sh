#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing zsh"
bash "$SCRIPT_DIR/zsh.sh"

echo "==> Installing oh-my-zsh"
bash "$SCRIPT_DIR/oh-my-zsh.sh"

echo "==> Installing mise"
bash "$SCRIPT_DIR/mise.sh"

echo "==> Linking mise config"
bash "$SCRIPT_DIR/link.sh"

echo "==> Installing tools"
bash "$SCRIPT_DIR/tools.sh"

echo "==> Installing fonts"
bash "$SCRIPT_DIR/fonts.sh"

echo ""
echo "Bootstrap complete. Restart your shell or run: exec zsh"
