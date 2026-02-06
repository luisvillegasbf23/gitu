#!/bin/sh
GITU_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BIN_DIR="${HOME}/.local/bin"

rm -f "$BIN_DIR/gitu"
rm -rf "$GITU_ROOT"

echo "gitu uninstalled."
echo "To remove ~/.local/bin from your PATH, edit your shell config and delete the gitu line."
