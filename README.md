# ZVM

Think nvm or pyenv — but for zig.

## Install

**bash/zsh:**

```sh
curl -sfL https://raw.githubusercontent.com/alde/zvm/master/install.sh | bash
```

**fish:**

```sh
curl -sfL https://raw.githubusercontent.com/alde/zvm/master/install.fish | fish
```

Restart your shell after installing.

## Usage

```sh
# install a zig version
zvm install 0.15.2

# install the nightly (dev) build
zvm install nightly

# update nightly to the latest dev build
zvm install nightly

# set the global default
zvm use 0.15.2

# see installed versions
zvm list

# see all available versions
zvm list-remote

# pin a version for the current project
zvm init
# or specify a version
zvm init 0.13.0

# check which zig binary is active
zvm which
```

## Per-project versions

Create a `.zvm` file in your project root containing the version string:

```
0.15.2
```

Or use `zvm init` to create one from the current default. When you run `zig`, the shim automatically picks up the version from the nearest `.zvm` file, walking up from the current directory. If none is found, the global default is used.

## How it works

- Zig versions are stored in `~/.zvm/versions/<version>/`
- The global default is stored in `~/.zvm/default`
- A lightweight shim at `~/.zvm/bin/zig` resolves the correct version at invocation time — no shell hooks, no startup overhead
- `ZVM_HOME` env var overrides the default `~/.zvm` location

## Requirements

- `bash`, `curl`, `tar`, `jq`
