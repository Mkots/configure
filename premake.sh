#!/usr/bin/env bash
set -euo pipefail

APT_UPDATED=0

apt_install() {
    local pkg="$1"
    if [ "$APT_UPDATED" -eq 0 ]; then
        sudo apt-get update -y
        APT_UPDATED=1
    fi
    sudo apt-get install -y "$pkg"
}

if command -v make &>/dev/null; then
    echo "make already installed: $(make --version | head -1)"
else
    echo "Installing build-essential..."
    apt_install build-essential
    echo "make installed: $(make --version | head -1)"
fi

if command -v curl &>/dev/null; then
    echo "curl already installed: $(curl --version | head -1)"
else
    echo "Installing curl..."
    apt_install curl
    echo "curl installed: $(curl --version | head -1)"
fi

if command -v wget &>/dev/null; then
    echo "wget already installed: $(wget --version | head -1)"
else
    echo "Installing wget..."
    apt_install wget
    echo "wget installed: $(wget --version | head -1)"
fi

if command -v git &>/dev/null; then
    echo "git already installed: $(git --version)"
else
    echo "Installing git..."
    apt_install git
    echo "git installed: $(git --version)"
fi
