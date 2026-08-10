#!/usr/bin/env bash
set -euo pipefail

# Branching happens here rather than in a Go template so that shellcheck sees
# every branch and the script can be run standalone for debugging.
case "$(uname -s)" in
Linux)
    sudo apt-get update -y
    sudo apt-get install -y build-essential curl wget git unzip fontconfig
    ;;
Darwin)
    if ! xcode-select -p &>/dev/null; then
        echo "Installing Xcode Command Line Tools..."
        xcode-select --install || true
        echo "A macOS dialog has been opened. Finish the install, then re-run chezmoi apply." >&2
        exit 1
    fi
    ;;
esac
