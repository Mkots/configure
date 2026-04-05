export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'icons' yes

plugins=(
    mise
    eza
    fzf
    git
    starship
    ssh
    zoxide
)

source $ZSH/oh-my-zsh.sh
