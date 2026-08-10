#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/install/lib.sh"

require_supported_os

# ---------------------------------------------------------------- linux (apt)

APT_UPDATED=0

apt_install() {
    local pkg="$1"
    if [ "$APT_UPDATED" -eq 0 ]; then
        sudo apt-get update -y
        APT_UPDATED=1
    fi
    sudo apt-get install -y "$pkg"
}

# ensure <command> <apt package>
ensure() {
    local bin="$1" pkg="$2"
    if have "$bin"; then
        echo "$bin already installed"
        return
    fi
    echo "Installing $pkg..."
    apt_install "$pkg"
    echo "$pkg installed"
}

premake_linux() {
    ensure make     build-essential
    ensure curl     curl
    ensure wget     wget
    ensure git      git
    ensure unzip    unzip
    ensure fc-cache fontconfig
}

# ---------------------------------------------------------------------- macos

premake_macos() {
    if ! xcode-select -p &>/dev/null; then
        echo "Installing Xcode Command Line Tools..."
        xcode-select --install || true
        echo ""
        echo "A macOS dialog has been opened. Finish the install, then re-run this script." >&2
        exit 1
    fi
    echo "Xcode Command Line Tools already installed: $(xcode-select -p)"

    # make, curl, git and unzip come with the Command Line Tools / base system
    for bin in make curl git unzip; do
        have "$bin" || die "$bin not found even though the Command Line Tools are installed."
        echo "$bin already installed"
    done

    # nothing in this repo needs wget; install it only if Homebrew happens to be around
    if have wget; then
        echo "wget already installed"
    elif have brew; then
        echo "Installing wget..."
        brew install wget
    else
        echo "wget not installed (optional on macOS)"
    fi
}

case "$OS" in
    linux) premake_linux ;;
    macos) premake_macos ;;
esac

echo ""
echo "Prerequisites ready. Next: make world"
