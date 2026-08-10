#!/bin/sh
# POSIX sh: works whether invoked as `./bootstrap.sh`, `bash bootstrap.sh`,
# or `sh -c "$(curl -fsLS .../bootstrap.sh)"` (dash on Debian has no pipefail).
set -eu

REPO="${DOTFILES_REPO:-mkots/configure}"
BIN_DIR="$HOME/.local/bin"
CHEZMOI_SRC="$HOME/.local/share/chezmoi"

CHEZMOI="$(command -v chezmoi || true)"
if [ -z "$CHEZMOI" ]; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
    export PATH="$BIN_DIR:$PATH"
    CHEZMOI="$BIN_DIR/chezmoi"
fi

# Authenticate GitHub API calls (used by chezmoi templates like gitHubLatestRelease).
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    GITHUB_TOKEN="$(gh auth token)"
    export GITHUB_TOKEN
fi

# Running from inside the local clone — use it directly, no download needed.
SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"
if [ -f "$SCRIPT_DIR/.chezmoiroot" ]; then
    echo "Using local repo: $SCRIPT_DIR"
    "$CHEZMOI" init --apply --force --source "$SCRIPT_DIR"

# gh is authenticated — clone/pull via gh to avoid unauthenticated rate limits.
elif command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    if [ -d "$CHEZMOI_SRC/.git" ]; then
        echo "Updating $CHEZMOI_SRC via gh..."
        git -C "$CHEZMOI_SRC" pull --ff-only
    else
        echo "Cloning $REPO via gh..."
        gh repo clone "$REPO" "$CHEZMOI_SRC" -- --depth=1
    fi
    "$CHEZMOI" apply --force

# Fallback: unauthenticated clone via chezmoi init.
else
    echo "Running chezmoi init --apply $REPO..."
    "$CHEZMOI" init --apply --force "$REPO"
fi

echo ""
echo "Bootstrap complete. Restart your shell or run: exec zsh"
