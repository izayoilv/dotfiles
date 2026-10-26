# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export PROTO_HOME="$HOME/.proto"
export NPM_CONFIG_PREFIX="$HOME/.local/share/npm"
export PNPM_HOME="$HOME/.local/share/pnpm"

for _proto_path in \
    "$HOME/.local/share/pnpm/bin" \
    "$HOME/.local/share/npm/bin" \
    "$HOME/go/bin" \
    "$HOME/.local/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.proto/bin" \
    "$HOME/.proto/shims"; do
    case ":$PATH:" in
        *":$_proto_path:"*) ;;
        *) PATH="$_proto_path:$PATH" ;;
    esac
done
export PATH
unset _proto_path

export DOTFILES_PROFILE_LOADED=1
