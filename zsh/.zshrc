# ~/.zshrc
# Oh My Zsh with cypher theme + fzf-tab + fzf history search

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cypher"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
)

source $ZSH/oh-my-zsh.sh

# --- fzf itself: Ctrl+R reverse search, Ctrl+T file finder, Alt+C cd finder ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# If installed via pacman/apt instead of the git installer, use this instead:
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh

# --- fzf-tab styling, tuned to the black/white/red palette ---
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' fzf-flags --color=fg:#d8d8d8,bg:#0a0a0a,hl:#e0102b --color=fg+:#f2f2f2,bg+:#161616,hl+:#e0102b --color=pointer:#e0102b,marker:#e0102b,prompt:#e0102b
zstyle ':fzf-tab:complete:*:*' fzf-preview 'ls --color=always $realpath 2>/dev/null'

# --- Vi-style keybindings ---
bindkey -v
export KEYTIMEOUT=1

# --- Autosuggestion / syntax highlighting colors ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red
ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[path]=fg=249

# --- Aliases ---
alias ls="ls --color=auto"
alias ll="ls -lah --color=auto"
alias grep="grep --color=auto"
alias vim="nvim"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias tm="tmux attach || tmux new"

# --- Environment ---
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export LESS="-R"

# --- Path additions ---
export PATH="$HOME/.local/bin:$PATH"
