#!/bin/sh
# POSIX sh: works whether invoked as `./bootstrap.sh`, `bash bootstrap.sh`,
# or `sh -c "$(curl -fsLS .../bootstrap.sh)"` (dash on Debian has no pipefail).
set -eu

REPO="${DOTFILES_REPO:-mkots/configure}"
BIN_DIR="$HOME/.local/bin"

CHEZMOI="$(command -v chezmoi || true)"
if [ -z "$CHEZMOI" ]; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
    export PATH="$BIN_DIR:$PATH"
    CHEZMOI="$BIN_DIR/chezmoi"
fi

# If the script lives inside the repo (has a sibling .chezmoiroot), use the
# local checkout as the source — no GitHub download needed.
SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"
if [ -f "$SCRIPT_DIR/.chezmoiroot" ]; then
    echo "Using local repo: $SCRIPT_DIR"
    "$CHEZMOI" init --apply --force --source "$SCRIPT_DIR"
else
    echo "Running chezmoi init --apply $REPO..."
    "$CHEZMOI" init --apply --force "$REPO"
fi

echo ""
echo "Bootstrap complete. Restart your shell or run: exec zsh"
