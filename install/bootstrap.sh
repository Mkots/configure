#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

require_supported_os

echo "==> Platform: $OS ($(uname -m))"

echo "==> Installing zsh"
bash "$SCRIPT_DIR/zsh.sh"

echo "==> Installing oh-my-zsh"
bash "$SCRIPT_DIR/oh-my-zsh.sh"

echo "==> Installing mise"
bash "$SCRIPT_DIR/mise.sh"

echo "==> Linking configs"
bash "$SCRIPT_DIR/link.sh"

echo "==> Installing tools"
bash "$SCRIPT_DIR/tools.sh"

echo "==> Installing fonts"
bash "$SCRIPT_DIR/fonts.sh"

echo ""
echo "Bootstrap complete. Restart your shell or run: exec zsh"
