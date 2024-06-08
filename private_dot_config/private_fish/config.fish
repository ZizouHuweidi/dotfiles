if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    # fastfetch
end

source ~/.config/fish/aliases.fish
source ~/.config/fish/functions.fish

fish_vi_key_bindings

set -x EDITOR nvim
set -x TERMINAL kitty
set -x BROWSER brave

set -x XDG_CONFIG_HOME ~/.config
set -x XDG_DATA_HOME ~/.local/share
set -x XDG_CACHE_HOME ~/.cache

set -x QT_QPA_PLATFORM wayland
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x SDL_VIDEODRIVER wayland
set -x _JAVA_AWT_WM_NONREPARENTING 1

fish_add_path -m ~/.bin
fish_add_path -m ~/.local/bin
set -x GOPATH $HOME/.local/share/go
fish_add_path -m $GOPATH/bin
# fish_add_path -m $HOME/.cargo/bin
set -x LANGUAGES_NODE_VERSION 'v21.7.3'
fish_add_path $HOME/.local/share/nvm/v$LANGUAGES_NODE_VERSION/bin
set -x BUN_INSTALL $HOME/.bun
fish_add_path -m $BUN_INSTALL/bin
set -Ua fish_user_paths "$HOME/.rye/shims"

# Key-bindings
bind -M insert \ce 'nvim $(fzf)'
bind -M insert \cf lf
bind -M insert \cn 'nvim .'
bind -M insert \cv nvim
bind -M insert \cg lazygit


zoxide init fish | source
starship init fish | source
