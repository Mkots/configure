# dotfiles

Portable shell configuration for macOS and Debian-based systems.

## Stack

- **Shell**: zsh + oh-my-zsh
- **Prompt**: starship (catppuccin theme)
- **Tools**: managed by mise
- **Plugins**: eza, fzf, zoxide, git, ssh

## Tools installed via mise

| Tool | Description |
|------|-------------|
| neovim | Text editor |
| eza | Modern `ls` replacement |
| zoxide | Smarter `cd` |
| fzf | Fuzzy finder |
| ripgrep | Fast grep |
| fd | Fast `find` |
| starship | Shell prompt |
| fastfetch | System info |
| gh | GitHub CLI |
| node | Node.js (LTS) |
| rust | Rust toolchain |

## Setup

On a fresh system:

```sh
# Install build tools and prerequisites
bash premake.sh

# Run full setup
make world
```

`make world` will:
1. Install zsh and set it as default shell
2. Install oh-my-zsh
3. Install mise
4. Symlink configs (`~/.zshrc`, `~/.zshenv`, `~/.config/mise`, `~/.config/starship.toml`)
5. Install all tools globally via mise
6. Install Iosevka Nerd Font

## Config files

| File | Symlinked to |
|------|-------------|
| `mise.toml` + `mise.lock` | `~/.config/mise/` |
| `mise/<os>.toml` | `~/.config/mise/conf.d/platform.toml` |
| `zsh/.zshrc` | `~/.zshrc` |
| `zsh/.zshenv` | `~/.zshenv` |
| `zsh/aliases.zsh` | `~/.oh-my-zsh/custom/aliases.zsh` |
| `starship/starship.toml` | `~/.config/starship.toml` |

## Platform differences

Everything shared lives in `mise.toml`; per-OS tools live in `mise/linux.toml`
and `mise/macos.toml`, linked into mise's `conf.d/`.

| | macOS | Debian |
|---|---|---|
| Prerequisites | Xcode Command Line Tools | `build-essential`, `curl`, `wget`, `git`, `unzip`, `fontconfig` |
| zsh | preinstalled | `apt-get install zsh` |
| eza | built from source (`cargo:eza`, ~2 min) — upstream ships no macOS binaries | prebuilt release binary |
| Fonts | `~/Library/Fonts` | `~/.local/share/fonts/NerdFonts` + `fc-cache` |

On macOS `premake.sh` only needs the Command Line Tools; Homebrew is optional
and is used solely to install `wget` if it happens to be present.
