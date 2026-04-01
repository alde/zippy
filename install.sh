#!/usr/bin/env bash
set -euo pipefail

ZVM_DIR="${ZVM_HOME:-$HOME/.zvm}"
REPO="https://raw.githubusercontent.com/alde/zvm/master"

echo "installing zvm..."

mkdir -p "$ZVM_DIR/bin" "$ZVM_DIR/versions"

# download zvm and shim
curl -sfL "$REPO/zvm" -o "$ZVM_DIR/zvm"
curl -sfL "$REPO/shim/zig" -o "$ZVM_DIR/bin/zig"
chmod +x "$ZVM_DIR/zvm" "$ZVM_DIR/bin/zig"

# symlink zvm into bin
ln -sf "$ZVM_DIR/zvm" "$ZVM_DIR/bin/zvm"

# detect shell and configure PATH
add_to_path='export PATH="$HOME/.zvm/bin:$PATH"'

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
    echo "done! restart your shell, then run: zvm help"
    exit 0
    ;;
esac

if ! grep -qF '.zvm/bin' "$rc" 2>/dev/null; then
  echo "" >> "$rc"
  echo "# zvm" >> "$rc"
  echo "$add_to_path" >> "$rc"
  echo "added zvm to PATH in $rc"
else
  echo "PATH already configured in $rc"
fi

echo ""
echo "done! restart your shell, then run: zvm help"
