#!/bin/sh
# Install gitu: curl -fsSL https://raw.githubusercontent.com/luisvillegasbf23/gitu/main/src/install.sh | sh

set -e

ARCHIVE_URL="${GITU_ARCHIVE_URL:-https://github.com/luisvillegasbf23/gitu/archive/refs/heads/main.tar.gz}"
GITU_DIR="${HOME}/.local/share/gitu"
BIN_DIR="${HOME}/.local/bin"

echo "Installing gitu..."
mkdir -p "$GITU_DIR" "$BIN_DIR"

curl -fsSL "$ARCHIVE_URL" | tar xz -C /tmp
cp -r /tmp/gitu-main/src/. "$GITU_DIR/"
rm -rf /tmp/gitu-main

chmod +x "$GITU_DIR/gitu"
for f in "$GITU_DIR"/commands/*.sh; do
  [ -f "$f" ] && chmod +x "$f"
done

printf '%s\n' '#!/bin/sh' "exec \"\$HOME/.local/share/gitu/gitu\" \"\$@\"" > "$BIN_DIR/gitu"
chmod +x "$BIN_DIR/gitu"

echo "Installed to $GITU_DIR (launcher at $BIN_DIR/gitu)"

case "${SHELL:-}" in
  *zsh*)   detected_shell=zsh;   config_to_source="${HOME}/.zshrc" ;;
  *bash*)  detected_shell=bash;  config_to_source="${HOME}/.bashrc" ;;
  *)       detected_shell=sh;    config_to_source="${HOME}/.profile" ;;
esac
echo "Detected shell: $detected_shell"

add_path_to() {
  config_path="$1"
  if [ ! -f "$config_path" ]; then
    return 1
  fi
  if grep -q '.local/bin' "$config_path" 2>/dev/null; then
    echo "$config_path already has ~/.local/bin in PATH"
    return 0
  fi
  echo '' >> "$config_path"
  echo '# gitu + other user binaries' >> "$config_path"
  echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> "$config_path"
  echo "Added ~/.local/bin to PATH in $config_path"
  return 0
}

added=0
case "$detected_shell" in
  zsh)  add_path_to "${HOME}/.zshrc" && added=1
        add_path_to "${HOME}/.bashrc" && added=1
        add_path_to "${HOME}/.profile" && added=1 ;;
  bash) add_path_to "${HOME}/.bashrc" && added=1
        add_path_to "${HOME}/.zshrc" && added=1
        add_path_to "${HOME}/.profile" && added=1 ;;
  *)    add_path_to "${HOME}/.profile" && added=1
        add_path_to "${HOME}/.bashrc" && added=1
        add_path_to "${HOME}/.zshrc" && added=1 ;;
esac

if [ "$added" -eq 0 ]; then
  echo "No .zshrc, .bashrc or .profile found. Add this line to your shell config:"
  echo '  export PATH="${HOME}/.local/bin:${PATH}"'
fi

echo "Done. You're using $detected_shell — run: source $config_to_source   (or open a new terminal)"
echo "Then run: gitu"
