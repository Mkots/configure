#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MISE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mise"

mkdir -p "$MISE_CONFIG_DIR"

link() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "already linked: $dst"
        return
    fi

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "Backing up existing $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    ln -sf "$src" "$dst"
    echo "linked: $dst -> $src"
}

STARSHIP_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$STARSHIP_CONFIG_DIR"

link "$REPO_DIR/mise.toml"                        "$MISE_CONFIG_DIR/config.toml"
link "$REPO_DIR/mise.lock"                        "$MISE_CONFIG_DIR/mise.lock"
link "$REPO_DIR/starship/starship.toml"           "$STARSHIP_CONFIG_DIR/starship.toml"

ZSH_CUSTOM="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}"
mkdir -p "$ZSH_CUSTOM"

link "$REPO_DIR/zsh/.zshenv"                      "$HOME/.zshenv"
link "$REPO_DIR/zsh/.zshrc"                       "$HOME/.zshrc"
link "$REPO_DIR/zsh/aliases.zsh"                  "$ZSH_CUSTOM/aliases.zsh"
