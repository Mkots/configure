#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

require_supported_os

if [ "$OS" = "macos" ]; then
    FONTS_DIR="$HOME/Library/Fonts"
else
    FONTS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/NerdFonts"
fi

font_installed() {
    if [ "$OS" = "macos" ]; then
        # no fontconfig on macOS, so look for the files themselves
        compgen -G "$FONTS_DIR/Iosevka*Nerd*" >/dev/null 2>&1
    else
        fc-list | grep -qi "Iosevka Nerd Font"
    fi
}

if font_installed; then
    echo "Iosevka Nerd Font already installed"
    exit 0
fi

have curl  || die "curl is required. Run premake.sh first."
have unzip || die "unzip is required. Run premake.sh first."

echo "Fetching latest Nerd Fonts release..."
LATEST=$(curl -fsSL "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" \
    | grep '"tag_name"' | cut -d'"' -f4)

echo "Downloading Iosevka Nerd Font $LATEST..."
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/$LATEST/Iosevka.zip" \
    -o "$TMP/Iosevka.zip"

mkdir -p "$FONTS_DIR"
unzip -qo "$TMP/Iosevka.zip" "*.ttf" -d "$FONTS_DIR"

# macOS picks up ~/Library/Fonts on its own; Linux needs the cache rebuilt
if have fc-cache; then
    fc-cache -f "$FONTS_DIR"
fi

echo "Iosevka Nerd Font $LATEST installed to $FONTS_DIR"
