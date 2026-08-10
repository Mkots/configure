alias vim="nvim"

# ~/.zshrc is managed by chezmoi — editing it directly gets overwritten on the
# next apply, so go through the source state instead. Single quotes keep
# $EDITOR resolving at call time rather than when the alias is defined.
alias ec='chezmoi edit --apply ~/.zshrc'
alias sc='exec zsh'

# lsd — replaces the oh-my-zsh eza plugin, which is gone because upstream eza
# ships no macOS binaries and building it from source pulled in a rust toolchain.
alias ls='lsd --group-dirs=first'
alias l='lsd -lA --group-dirs=first --git'
alias ll='lsd -l --group-dirs=first --git'
alias la='lsd -lA --group-dirs=first --git'
alias lt='lsd --tree --depth=2 --group-dirs=first'
