# dotfiles

Portable shell configuration for Debian-based systems.

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
| `zsh/.zshrc` | `~/.zshrc` |
| `zsh/.zshenv` | `~/.zshenv` |
| `zsh/aliases.zsh` | `~/.oh-my-zsh/custom/aliases.zsh` |
| `starship/starship.toml` | `~/.config/starship.toml` |


GPG test
