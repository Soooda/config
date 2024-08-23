setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# Autoload
autoload -U compinit; compinit
zmodload zsh/complist

# Auto Completion
zstyle ":completion:*:*:*:*:*" menu select
zstyle ":completion:*" use-cache yes
zstyle ":completion:*" special-dirs true
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" file-sort change
zstyle ":completion:*" matcher-list "m:{[:lower:][:upper:]}={[:upper:][:lower:]}" "r:|=*" "l:|=* r:|=*"

# PATH

# Variables
export EDITOR="nvim"
export VISUAL="nvim"
export HOMEBREW_NO_ANALYTICS=1

# Aliases
alias s="neofetch"
alias lg="lazygit"
alias vi="\vim"
alias vim="nvim"
alias du="dust -r -n 999999999"
alias ls="ls --color=auto"

# Initialize tools
source <(fzf --zsh) # Fuzzy File Search
# Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
eval "$(starship init zsh)" # Starship
eval "$(zoxide init zsh)" # Zoxide
# colored-man-pages
autoload -U colors && colors
source ~/.config/zsh/plugins/colored-man-pages.zsh
# zsh-syntax-highlighting
if [ ! -d "$HOME/.config/zsh/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/plugins/zsh-syntax-highlighting
fi
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
if [ ! -d "$HOME/.config/zsh/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
fi
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Startup Commands
neofetch
