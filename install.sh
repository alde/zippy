#!/usr/bin/env bash
set -euo pipefail

ZIPPY_DIR="${ZIPPY_HOME:-$HOME/.zippy}"
REPO="https://raw.githubusercontent.com/alde/zippy/master"

echo "installing zippy..."

mkdir -p "$ZIPPY_DIR/bin" "$ZIPPY_DIR/versions"

# download zippy and shim
curl -sfL "$REPO/zippy" -o "$ZIPPY_DIR/zippy"
curl -sfL "$REPO/shim/zig" -o "$ZIPPY_DIR/bin/zig"
chmod +x "$ZIPPY_DIR/zippy" "$ZIPPY_DIR/bin/zig"

# symlink zippy into bin
ln -sf "$ZIPPY_DIR/zippy" "$ZIPPY_DIR/bin/zippy"

# detect shell and configure PATH
add_to_path='export PATH="$HOME/.zippy/bin:$PATH"'

shell_name="$(basename "$SHELL")"
case "$shell_name" in
  bash)
    rc="$HOME/.bashrc"
    [[ -f "$HOME/.bash_profile" ]] && rc="$HOME/.bash_profile"
    ;;
  zsh)
    rc="$HOME/.zshrc"
    ;;
  *)
    echo ""
    echo "add this to your shell config:"
    echo "  $add_to_path"
    echo ""
    echo "done! restart your shell, then run: zippy help"
    exit 0
    ;;
esac

if ! grep -qF '.zippy/bin' "$rc" 2>/dev/null; then
  echo "" >> "$rc"
  echo "# zippy" >> "$rc"
  echo "$add_to_path" >> "$rc"
  echo "added zippy to PATH in $rc"
else
  echo "PATH already configured in $rc"
fi

echo ""
echo "done! restart your shell, then run: zippy help"
