# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh - Installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh - Plugins
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  git-auto-fetch
  zsh-syntax-highlighting
  zsh-autosuggestions
  direnv
  tmux
)

# Zsh tmux
ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zoxide for navigation
eval "$(zoxide init zsh)"

# SDKMAN
source "$HOME/.sdkman/bin/sdkman-init.sh"

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Fuzzy Find
source <(fzf --zsh)

# Use fd instead of fzf 

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
