#!/usr/bin/env bash
set -euo pipefail

if ! command -v mise &>/dev/null; then
    echo "Error: mise is required. Run install/mise.sh first." >&2
    exit 1
fi

mise install

echo "All tools installed globally."
