#!/usr/bin/env bash
# Shared helpers for the install scripts. Meant to be sourced, not executed.

case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux)  OS="linux" ;;
    *)      OS="unsupported" ;;
esac

# mise installs here; make it visible to the install scripts themselves so a
# fresh run can use mise right after installing it
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) PATH="$HOME/.local/bin:$PATH" ;;
esac
export PATH

have() {
    command -v "$1" &>/dev/null
}

die() {
    echo "Error: $*" >&2
    exit 1
}

require_supported_os() {
    if [ "$OS" = "unsupported" ]; then
        die "unsupported platform: $(uname -s). Supported: macOS, Debian-based Linux."
    fi

    if [ "$OS" = "linux" ] && ! have apt-get; then
        die "unsupported Linux distribution: apt-get not found."
    fi
}
