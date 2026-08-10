#!/usr/bin/env bash
set -euo pipefail

# run_once_ scripts re-run whenever their contents change, so guard the install
# instead of blindly re-downloading mise on every edit to this file.
if command -v mise >/dev/null 2>&1 || [ -x "$HOME/.local/bin/mise" ]; then
    echo "mise already installed, skipping."
    exit 0
fi

curl -sSf https://mise.run | sh
