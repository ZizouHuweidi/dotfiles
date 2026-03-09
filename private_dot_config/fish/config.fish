if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    # fastfetch
end

fish_config theme choose Base16\ Default\ Dark

source ~/.config/fish/aliases.fish

fish_vi_key_bindings

# set -x EDITOR nvim
# set -x TERMINAL ghostty
# set -x BROWSER google-chrome
#
# set -x XDG_CONFIG_HOME ~/.config
# set -x XDG_DATA_HOME ~/.local/share
# set -x XDG_CACHE_HOME ~/.cache
#
# set -x QT_QPA_PLATFORM wayland
# set -x QT_QPA_PLATFORMTHEME qt5ct
# set -x SDL_VIDEODRIVER wayland
# set -x _JAVA_AWT_WM_NONREPARENTING 1

fish_add_path -m ~/.bin
fish_add_path -m ~/.local/bin
set -x GOPATH $HOME/.local/share/go
fish_add_path -m $GOPATH/bin
fish_add_path -m $HOME/.cargo/bin
set -x BUN_INSTALL $HOME/.bun
fish_add_path -m $BUN_INSTALL/bin
fish_add_path -m /var/home/linuxbrew/.linuxbrew/bin

# Key-bindings
bind -M insert \ce 'nvim $(fzf)'
bind -M insert \cf yazi
bind -M insert \cn 'nvim .'
bind -M insert \cv nvim
bind -M insert \cg lazygit
bind -M insert \ch htop

# eval "$(/var/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
starship init fish | source
zoxide init fish | source
