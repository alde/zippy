#!/usr/bin/env fish

set ZVM_DIR (set -q ZVM_HOME; and echo $ZVM_HOME; or echo $HOME/.zvm)
set REPO "https://raw.githubusercontent.com/alde/zvm/master"

echo "installing zvm..."

mkdir -p $ZVM_DIR/bin $ZVM_DIR/versions

# download zvm and shim
curl -sfL $REPO/zvm -o $ZVM_DIR/zvm
curl -sfL $REPO/shim/zig -o $ZVM_DIR/bin/zig
chmod +x $ZVM_DIR/zvm $ZVM_DIR/bin/zig

# symlink zvm into bin
ln -sf $ZVM_DIR/zvm $ZVM_DIR/bin/zvm

# configure PATH in fish
set -l fish_conf_dir $HOME/.config/fish
set -l conf $fish_conf_dir/conf.d/zvm.fish

if not test -f $conf
    mkdir -p $fish_conf_dir/conf.d
    echo '# zvm' > $conf
    echo 'fish_add_path $HOME/.zvm/bin' >> $conf
    echo "added zvm to PATH in $conf"
else
    echo "PATH already configured in $conf"
end

echo ""
echo "done! restart your shell, then run: zvm help"
