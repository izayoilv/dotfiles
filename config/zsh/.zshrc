HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

setopt AUTO_CD
setopt BEEP
setopt EXTENDED_GLOB
setopt NOMATCH
setopt NOTIFY
setopt CORRECT
setopt PROMPT_SUBST
setopt RC_QUOTES

bindkey -v

zstyle ':completion:*' menu select
zstyle ':completion:*' loader yes
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
autoload -Uz +X bashcompinit

add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"
add_to_path "$HOME/.npm-global/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.composer/vendor/bin"
add_to_path "$HOME/.dotnet/tools"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/.opencode/bin"

if [[ -s "$HOME/.config/envman/load.sh" ]]; then
    source "$HOME/.config/envman/load.sh"
fi
if [[ -s "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME/bin:"* ]] && export PATH="$PNPM_HOME/bin:$PATH"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

export BERG_BASE_URL="codeberg.org"
# export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
export PLAYWRIGHT_BROWSERS_PATH="$HOME/.cache/ms-playwright"
export KUBECONFIG="$HOME/.kube/config"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

if (( $+commands[sheldon] )); then
    eval "$(sheldon source)"
fi

compinit
bashcompinit

if (( $+widgets[history-substring-search-up] )); then
    bindkey -M viins $'\e[A'  history-substring-search-up
    bindkey -M viins $'\eOA' history-substring-search-up
    bindkey -M viins $'\e[B'  history-substring-search-down
    bindkey -M viins $'\eOB' history-substring-search-down
    bindkey -M vicmd $'\e[A'  history-substring-search-up
    bindkey -M vicmd $'\eOA' history-substring-search-up
    bindkey -M vicmd $'\e[B'  history-substring-search-down
    bindkey -M vicmd $'\eOB' history-substring-search-down
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi
if (( $+commands[fzf] )); then
    if [[ -f "$HOME/.fzf.zsh" ]]; then
        source "$HOME/.fzf.zsh"
    elif [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
        source /usr/share/fzf/shell/key-bindings.zsh
    fi
fi

alias la='ls -la'
alias ll='ls -l'
alias l.='ls -d .*'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

if (( $+commands[fastfetch] )); then
    fastfetch
fi
