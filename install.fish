#!/usr/bin/env fish

set ZIPPY_DIR (set -q ZIPPY_HOME; and echo $ZIPPY_HOME; or echo $HOME/.zippy)
set REPO "https://raw.githubusercontent.com/alde/zippy/master"

echo "installing zippy..."

mkdir -p $ZIPPY_DIR/bin $ZIPPY_DIR/versions

# download zippy and shim
curl -sfL $REPO/zippy -o $ZIPPY_DIR/zippy
curl -sfL $REPO/shim/zig -o $ZIPPY_DIR/bin/zig
chmod +x $ZIPPY_DIR/zippy $ZIPPY_DIR/bin/zig

# symlink zippy into bin
ln -sf $ZIPPY_DIR/zippy $ZIPPY_DIR/bin/zippy

# configure PATH in fish
set -l fish_conf_dir $HOME/.config/fish
set -l conf $fish_conf_dir/conf.d/zippy.fish

if not test -f $conf
    mkdir -p $fish_conf_dir/conf.d
    echo '# zippy' > $conf
    echo 'fish_add_path $HOME/.zippy/bin' >> $conf
    echo "added zippy to PATH in $conf"
else
    echo "PATH already configured in $conf"
end

echo ""
echo "done! restart your shell, then run: zippy help"
