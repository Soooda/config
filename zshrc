setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# Autoload
autoload -Uz compinit; compinit -u
autoload -Uz colors && colors
zmodload zsh/complist

# Auto Completion
zstyle ":completion:*" menu select
# BSD ls colors (no dircolors on macOS)
export CLICOLOR=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
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
alias s="fastfetch"
alias ls="lsd"
alias lg="lazygit"
alias vi="\vim"
alias vim="nvim"
alias du="dust -r -n 1000"

# Frok from: https://github.com/ohmyzsh/ohmyzsh/blob/71cc861806f30d8f7fd3d0040db86737cab62581/lib/directories.zsh
alias -g ..='../'
alias -g ...='../..'
alias -g ....='../../..'

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

eval "$(starship init zsh)" # Starship
eval "$(zoxide init zsh)" # Zoxide
# colored-man-pages
source ~/.config/zsh/plugins/colored-man-pages.zsh
# zsh-syntax-highlighting
if [ ! -f "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/plugins/zsh-syntax-highlighting
fi
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
if [ ! -f "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
fi
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Startup Commands
fastfetch
