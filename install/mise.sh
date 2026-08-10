#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

require_supported_os

if have mise; then
    echo "mise already installed: $(mise --version)"
    exit 0
fi

echo "Installing mise..."
curl -sSf https://mise.run | sh

# activation is handled by the oh-my-zsh `mise` plugin in zsh/.zshrc, and
# zsh/.zshenv puts ~/.local/bin on PATH so the plugin can find the binary
echo "mise installed: $("$HOME/.local/bin/mise" --version)"
