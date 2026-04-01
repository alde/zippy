# Zippy

Think nvm or pyenv — but for zig.

## Install

**bash/zsh:**

```sh
curl -sfL https://raw.githubusercontent.com/alde/zippy/master/install.sh | bash
```

**fish:**

```sh
curl -sfL https://raw.githubusercontent.com/alde/zippy/master/install.fish | fish
```

Restart your shell after installing.

## Usage

```sh
# install a zig version
zippy install 0.15.2

# install the nightly (dev) build
zippy install nightly

# update nightly to the latest dev build
zippy install nightly

# set the global default
zippy use 0.15.2

# see installed versions
zippy list

# see all available versions
zippy list-remote

# pin a version for the current project
zippy init
# or specify a version
zippy init 0.13.0

# check which zig binary is active
zippy which
```

## Per-project versions

Create a `.zippy` file in your project root containing the version string:

```
0.15.2
```

Or use `zippy init` to create one from the current default. When you run `zig`, the shim automatically picks up the version from the nearest `.zippy` file, walking up from the current directory. If none is found, the global default is used.

## How it works

- Zig versions are stored in `~/.zippy/versions/<version>/`
- The global default is stored in `~/.zippy/default`
- A lightweight shim at `~/.zippy/bin/zig` resolves the correct version at invocation time — no shell hooks, no startup overhead
- `ZIPPY_HOME` env var overrides the default `~/.zippy` location

## Requirements

- `bash`, `curl`, `tar`, `jq`
