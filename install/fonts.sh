#!/usr/bin/env bash
set -euo pipefail

FONT_NAME="IosevkaNerdFont"
FONTS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/NerdFonts"

if fc-list | grep -qi "Iosevka Nerd Font"; then
    echo "Iosevka Nerd Font already installed"
    exit 0
fi

if ! command -v curl &>/dev/null; then
    echo "Error: curl is required. Run install/premake.sh first." >&2
    exit 1
fi

echo "Fetching latest Nerd Fonts release..."
LATEST=$(curl -fsSL "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" \
    | grep '"tag_name"' | cut -d'"' -f4)

echo "Downloading Iosevka Nerd Font $LATEST..."
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/$LATEST/Iosevka.zip" \
    -o "$TMP/Iosevka.zip"

mkdir -p "$FONTS_DIR"
unzip -q "$TMP/Iosevka.zip" "*.ttf" -d "$FONTS_DIR"

fc-cache -f "$FONTS_DIR"

echo "Iosevka Nerd Font $LATEST installed"
