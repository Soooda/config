setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# Autoload
autoload -Uz compinit; compinit
autoload -Uz colors && colors
zmodload zsh/complist

# Auto Completion
zstyle ":completion:*" menu select
if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  alias ls='ls --color'
else
  export CLICOLOR=1
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
fi
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
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
