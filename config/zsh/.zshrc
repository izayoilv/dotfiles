[[ $- != *i* ]] && return

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"

add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path "/sbin"
add_to_path "/usr/sbin"
add_to_path "/usr/local/sbin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.composer/vendor/bin"
add_to_path "$HOME/.dotnet/tools"
add_to_path "$HOME/go/bin"
add_to_path "$ANDROID_HOME/cmdline-tools/latest/bin"
add_to_path "$ANDROID_HOME/platform-tools"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export BERG_BASE_URL="codeberg.org"
# export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
export PLAYWRIGHT_BROWSERS_PATH="$HOME/.cache/ms-playwright"
export KUBECONFIG="$HOME/.kube/config"
export EDITOR=nvim VISUAL=nvim

export SUPERPOWERS_DISABLE_TELEMETRY=true

export LIBVIRT_DEFAULT_URI=qemu:///system

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FCNTL_LOCK
setopt EXTENDED_HISTORY
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
compinit
bashcompinit

if [[ -s "$HOME/.config/envman/load.sh" ]]; then
    source "$HOME/.config/envman/load.sh"
fi
if [[ -s "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

if (( $+commands[sheldon] )); then
    eval "$(sheldon source)"
fi
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
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

if (( $+widgets[history-substring-search-up] )); then
    bindkey -M viins $'\e[A'  history-substring-search-up
    bindkey -M viins $'\eOA' history-substring-search-up
    bindkey -M viins $'\eOB' history-substring-search-down
    bindkey -M vicmd $'\e[A'  history-substring-search-up
    bindkey -M vicmd $'\eOA' history-substring-search-up
    bindkey -M vicmd $'\e[B'  history-substring-search-down
    bindkey -M vicmd $'\eOB' history-substring-search-down
fi

alias la='ls -a'
alias ll='ls -l'
alias l.='ls -d .*'
alias clear-history='clear; : > $HISTFILE && fc -R; fastfetch'
alias sz="source $ZDOTDIR/.zshrc"

if [[ $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]]; then
  zcompile $ZDOTDIR/.zshrc
fi

if (( $+commands[fastfetch] )); then
    fastfetch
fi

if (( $+commands[proto] )); then
    eval "$(proto activate zsh)"
fi
