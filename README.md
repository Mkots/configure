# dotfiles

Portable shell configuration for macOS and Debian-based systems, managed by
[chezmoi](https://www.chezmoi.io/).

## Stack

- **Shell**: zsh + oh-my-zsh
- **Prompt**: starship (catppuccin theme)
- **Tools**: managed by mise
- **Plugins**: fzf, zoxide, git, ssh

## Tools installed via mise

| Tool | Description |
|------|-------------|
| neovim | Text editor |
| lsd | Modern `ls` replacement |
| zoxide | Smarter `cd` |
| fzf | Fuzzy finder |
| ripgrep | Fast grep |
| fd | Fast `find` |
| starship | Shell prompt |
| fastfetch | System info |
| gh | GitHub CLI |

Language runtimes (node, rust) are deliberately **not** managed here — install
them per project with `mise use`.

## Setup

On a fresh system:

```sh
sh -c "$(curl -fsLS https://raw.githubusercontent.com/mkots/configure/main/bootstrap.sh)"
```

or, if you already cloned the repo:

```sh
./bootstrap.sh
```

This installs chezmoi (if not already present) and applies the source state,
which:
1. Runs the `.chezmoiscripts/` in order: apt packages / Xcode CLT, zsh install
   + `chsh`, mise install, `mise install` (tool versions).
2. Applies all managed dotfiles.
3. Fetches externals (oh-my-zsh, Iosevka Nerd Font).

When run from inside a clone, `bootstrap.sh` pins that clone as `sourceDir` in
`~/.config/chezmoi/chezmoi.toml`. Without that pin a bare `chezmoi apply` falls
back to `~/.local/share/chezmoi` and silently acts on a different copy.

## Who owns what

- **`.chezmoidata/`** owns every version and path that chezmoi itself fetches.
  Templates are pure functions of committed data: they never call the network
  to decide what to install, so `chezmoi apply` is reproducible and needs no
  GitHub token.
- **chezmoi** owns bootstrap sequencing and every managed file. Shell code only
  exists in `.chezmoiscripts/`, and only for steps that mutate the system (apt,
  Xcode CLT, zsh install, `chsh`, mise install).
- **mise** owns tool versions (`home/dot_config/mise/config.toml`) and a small
  set of maintenance tasks (`mise.toml` at the repo root).

Two rules keep the layers from fighting:

- **OS branching lives in shell, not in templates.** A `.tmpl` suffix is only
  for injecting data or a `run_onchange` trigger hash. Everything else uses
  `case "$(uname -s)"`, so shellcheck sees every branch on every machine.
- **Files that a tool rewrites are symlinked into the repo, not copied.**
  `~/.config/mise/mise.lock` is a symlink to `state/mise.lock`, so `mise lock`
  writes straight into the source and can never drift out of sync.

## Repo layout

```
.
├── .chezmoiroot          # contains: home
├── bootstrap.sh          # installs chezmoi, pins sourceDir, applies
├── mise.toml             # repo maintenance tasks + shellcheck
├── state/mise.lock       # real lockfile; ~/.config/mise/mise.lock links here
└── home/                 # chezmoi source directory
    ├── .chezmoidata/                # pinned versions and per-OS paths
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
| `lint` | Shellcheck every script, plain and templated |
| `update` | `mise upgrade --bump` → re-add the config → `mise lock --global` → `mise install` → apply |
| `check` | `lint` + `chezmoi verify` |

`mise lock` defaults to the *project* config root, which from this repo holds
no machine tools — `--global` is what actually refreshes `state/mise.lock`.

## Bumping the font

Nerd Fonts are pinned in `home/.chezmoidata/versions.toml`. Bump the tag there
and commit; `run_onchange_after_40-fc-cache.sh.tmpl` re-runs automatically on
Linux.

## Platform differences

Tool versions are identical everywhere — `home/dot_config/mise/config.toml`
needs no templating at all. One version is pinned for hardware reasons: `fd`
stays at 10.3.0 because 10.4+ ships no `x86_64-apple-darwin` build and all
machines share one lockfile.

| | macOS | Debian |
|---|---|---|
| Prerequisites | Xcode Command Line Tools | `build-essential`, `curl`, `wget`, `git`, `unzip`, `fontconfig` |
| zsh | preinstalled | `apt-get install zsh` |
| Fonts | `~/Library/Fonts/NerdFonts` | `~/.local/share/fonts/NerdFonts` + `fc-cache` |

On macOS the prerequisites script only checks for the Command Line Tools; there
is no Homebrew dependency.
