export EDITOR="nvim"

# zsh keeps $path and $PATH in sync; -U drops duplicates on re-source
typeset -U path PATH

# user-local binaries (this is where mise installs itself)
path=("$HOME/.local/bin" $path)

# Homebrew, if present (Apple Silicon first, then Intel)
for _brew_prefix in /opt/homebrew /usr/local; do
    if [[ -x "$_brew_prefix/bin/brew" ]]; then
        export HOMEBREW_PREFIX="$_brew_prefix"
        path=("$_brew_prefix/bin" "$_brew_prefix/sbin" $path)
        break
    fi
done
unset _brew_prefix
