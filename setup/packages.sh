sudo pacman -Syy
sudo pacman -S cosmic
sudo pacman --needed --noconfirm -S chezmoi lm_sensors lshw gdu htop gparted upower tlp tlpui
sudo pacman --needed --noconfirm -S zathura zathura-pdf-mupdf neovim neovide
sudo pacman --needed --noconfirm -S lf transmission-gtk transmission-cli yt-dlp fastfetch android-file-transfer cmus
sudo pacman --needed --noconfirm -S ghostty python-pillow bat fish grc fzf ripgrep fd starship tldr zoxide xwaylandvideobridge
yay --needed --noconfirm -S firefox visual-studio-code-bin zed

sudo pacman --needed --noconfirm -S gimp obsidian
sudo pacman --needed --noconfirm -S go hugo ollama protobuf syncthing rsync docker docker-compose
sudo pacman --needed --noconfirm -S python-pip python-pipx python-poetry rye python-ipykernel
yay --needed --noconfirm -S nvm npm
sudo pacman --needed --noconfirm -S net-tools ntfs-3g ventoy-bin virt-manager

## fonts
sudo pacman --needed --noconfirm -S font-manager noto-fonts ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-noto-nerd otf-font-awesome
sudo pacman --needed --noconfirm -S adobe-source-code-pro-fonts adobe-source-sans-fonts
sudo pacman --needed --noconfirm -S noto-fonts-emoji nerd-fonts-source-code-pro awesome-terminal-fonts nerd-fonts-jetbrains-mono ttf-jetbrains-mono
sudo pacman --needed --noconfirm -S ttf-font-awesome ttf-hack ttf-fira-code ttf-iosevka-nerd ttf-material-design-iconic-font noto-fonts-emoji
sudo pacman --needed --noconfirm -S ttf-meslo-nerd-font-powerlevel10k ttf-ms-fonts ttf-ubuntu-font-family fontconfig
yay --needed --noconfirm -S ttf-proggy-clean noto-color-emoji-fontconfig
fc-cache
