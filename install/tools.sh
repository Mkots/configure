#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

have mise || die "mise is required. Run install/mise.sh first."

if [ "$OS" = "macos" ]; then
    # eza is built from source on macOS, so cargo has to exist first
    echo "Installing rust toolchain (needed to build eza)..."
    mise install rust
fi

mise install

echo "All tools installed globally."
