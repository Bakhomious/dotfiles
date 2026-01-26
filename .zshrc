# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh - Installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

eval "$(/opt/homebrew/bin/brew shellenv)"

# Oh My Zsh - Plugins
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  git-auto-fetch
  zsh-syntax-highlighting
  zsh-autosuggestions
  tmux
  fzf-tab
)

# Zsh tmux
ZSH_TMUX_AUTOSTART=false

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zoxide for navigation
eval "$(zoxide init zsh)"

# Fuzzy Find
source <(fzf --zsh)

# Use fd instead of fzf 

export FZF_COMPLETION_TRIGGER="**"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Git support for fzf
# curl -sSLo ~/.fzf-git.sh https://raw.githubusercontent.com/junegunn/fzf-git.sh/refs/heads/main/fzf-git.sh
source ~/.fzf-git.sh

# Bat
export BAT_THEME=Dracula

# Preview for fzf

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# eza
alias ls="eza --color=always --icons=always"

# the fuck
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# managing dotfiles with git
# prior cmd: git init --bare $HOME/.cfg 
#            alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
#            config config --local status.showUntrackedFiles no
alias config='/usr/bin/git --git-dir=/Users/bbasta/.cfg/ --work-tree=/Users/bbasta'

# Key Bindings for Ghostty
bindkey "^[[1;3D" backward-word # Alt + Left
bindkey "^[[1;3C" forward-word  # Alt + Right

# uv
export PATH="/Users/bbasta/.local/bin:$PATH"
export POSTING_EDITOR="nvim"

# pnpm
export PNPM_HOME="/Users/bbasta/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Docker Colima
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock

# Yazi 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Editor
export EDITOR=nvim

# Vim mode

set -o vi

# Aliases
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

cx() { cd "$@" && l; }


# Autocomplete
autoload -Uz compinit
compinit

# IntelliJ Idea
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"
idea() { command idea "$@" >/dev/null 2>&1 & disown }

# Kubectl
alias k="kubectl"
alias kgpo="kubectl get pods"

# Functions
jwtd() {
  local token=${1:-$(cat)}
  jq -R 'split(".") |.[0:2] | map(gsub("-"; "+") | gsub("_"; "/") | gsub("%3D"; "=") | @base64d) | map(fromjson)' <<<$token
}

gitamend() {
    git commit -a --amend --no-edit "$@"
}

alias gitlogl="git log --oneline"

# Python
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"

# Libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

# Mise
alias m="mise run"
eval "$(mise activate zsh)"

enable-fzf-tab
