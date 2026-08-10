# dotfiles

Portable shell configuration for macOS and Debian-based systems, managed by
[chezmoi](https://www.chezmoi.io/).

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
sh -c "$(curl -fsLS https://raw.githubusercontent.com/mkots/configure/main/bootstrap.sh)"
```

or, if you already cloned the repo:

```sh
./bootstrap.sh
```

This installs chezmoi (if not already present) and runs
`chezmoi init --apply mkots/configure`, which:
1. Runs the `.chezmoiscripts/` in order: apt packages / Xcode CLT, zsh install
   + `chsh`, mise install, `mise install` (tool versions).
2. Applies all managed dotfiles.
3. Fetches externals (oh-my-zsh, Iosevka Nerd Font).

## Who owns what

- **chezmoi** owns bootstrap sequencing and every managed file — all
  symlinking, platform branching, and external asset fetching is declarative.
  Shell code only exists in `.chezmoiscripts/`, and only for steps that
  mutate the system (apt, Xcode CLT, zsh install, `chsh`, mise install).
- **mise** owns tool versions (`dot_config/mise/config.toml.tmpl`) and a
  small set of maintenance tasks (`mise.toml` at the repo root), run after
  the machine is already bootstrapped.

## Repo layout

```
.
├── .chezmoiroot          # contains: home
├── bootstrap.sh          # installs chezmoi, then init --apply
├── mise.toml             # repo maintenance tasks (diff/apply/lint/update/ci)
└── home/                 # chezmoi source directory
    ├── .chezmoiexternal.toml.tmpl   # oh-my-zsh, Iosevka Nerd Font
    ├── .chezmoiscripts/             # apt/CLT, zsh, mise install, tool install
    └── dot_config/, dot_zshenv, dot_zshrc, ...
```

## Maintenance tasks

Run with `mise run <task>` from the repo root:

| Task | What it does |
|------|-------------|
| `diff` | Show what `chezmoi apply` would change in `$HOME` |
| `apply` | Apply the chezmoi source state to `$HOME` |
| `lint` | Shellcheck every rendered `.chezmoiscripts/` script |
| `update` | `mise upgrade` → `mise lock` → `chezmoi re-add` the lockfile → `chezmoi apply` |
| `ci` | `lint` + `chezmoi verify` |

## Platform differences

Shared tool versions live in `home/dot_config/mise/config.toml.tmpl`; the
only per-OS entry (`eza`) is templated with
`{{ if eq .chezmoi.os "darwin" }}`.

| | macOS | Debian |
|---|---|---|
| Prerequisites | Xcode Command Line Tools | `build-essential`, `curl`, `wget`, `git`, `unzip`, `fontconfig` |
| zsh | preinstalled | `apt-get install zsh` |
| eza | built from source (`cargo:eza`, ~2 min) — upstream ships no macOS binaries | prebuilt release binary |
| Fonts | `~/Library/Fonts/NerdFonts` | `~/.local/share/fonts/NerdFonts` + `fc-cache` |

On macOS, the prerequisites script only checks for the Command Line Tools;
there is no Homebrew dependency.
