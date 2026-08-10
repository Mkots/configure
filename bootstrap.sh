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

echo "Running chezmoi init --apply $REPO..."
# --force: overwrite files that changed since chezmoi last wrote them
# (e.g. mise.lock updated by `mise install` on a prior run).
"$CHEZMOI" init --apply --force "$REPO"

echo ""
echo "Bootstrap complete. Restart your shell or run: exec zsh"
