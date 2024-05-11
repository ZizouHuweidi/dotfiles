install_packages() {
	echo -e "[*3*] Installing essential packages with Pacman."

	## setup
	sudo pacman -Syy
	sudo pacman --needed --noconfirm -S polkit-gnome
	sudo pacman --needed --noconfirm -S chezmoi
	sudo pacman --needed --noconfirm -S adw-gtk3-git adwaita-qt5 adwaita-qt6 gradience

	## hardware
	sudo pacman --needed --noconfirm -S lm_sensors lshw gdu brightnessctl htop gparted
	sudo pacman --needed --noconfirm -S upower tlp tlpui
	sudo pacman --needed --noconfirm -S gammastep

	## files
	sudo pacman --needed --noconfirm -S zathura zathura-pdf-mupdf thunar
	sudo pacman --needed --noconfirm -S neovim neovide file-roller
	sudo pacman --needed --noconfirm -S lf transmission-gtk transmission-cli ffmpegthumbnailer yt-dlp

	## themes
	sudo pacman --needed --noconfirm -S kvantum neofetch qt5ct qt6ct
	sudo pacman --needed --noconfirm -S nwg-look
	yay --needed --noconfirm -S gruvbox-material-icon-theme-git adw-gtk3-dark
	sudo pacman --needed --noconfirm -S android-file-transfer

	## audio
	sudo pacman --needed --noconfirm -S mpv alsa-utils pamixer cmus
	sudo pacman --needed --noconfirm -S pavucontrol

	## images
	sudo pacman --needed --noconfirm -S imv feh imagemagick

	## network
	sudo pacman --needed --noconfirm -S network-manager-applet networkmanager nm-connection-editor wireless_tools
	sudo pacman --needed --noconfirm -S blueman
	# sudo pacman --needed --noconfirm -S kdeconnect

	## browsers
	yay --needed --noconfirm -S vivaldi

	## terminals
	sudo pacman --needed --noconfirm -S kitty python-pillow bat
	sudo pacman --needed --noconfirm -S zsh bash-completion fzf fzf-tab-bin-git zsh-autosuggestions zsh-syntax-highlighting ripgrep fd starship tldr zoxide

	## sway
	sudo pacman --needed --noconfirm -S sway swaybg swayidle swaylock xdg-desktop-portal-wlr
	sudo pacman --needed --noconfirm -S waybar
	# yay --needed --noconfirm -S swayhide

	# wayland
	sudo pacman --needed --noconfirm -S light slurp grim rofi swappy xorg-xwayland polkit-gnome
	yay --needed --noconfirm -S dunst cliphist nwg-look wlogout emote wdisplays wl-clipboard wf-recorder wob
	sudo pacman --needed --noconfirm -S tesseract-data-eng wl-mirror xwaylandvideobridge 

	## fonts
	sudo pacman --needed --noconfirm -S font-manager noto-fonts ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-noto-nerd
	sudo pacman --needed --noconfirm -S adobe-source-code-pro-fonts adobe-source-sans-fonts 
	sudo pacman --needed --noconfirm -S noto-fonts-emoji nerd-fonts-source-code-pro awesome-terminal-fonts nerd-fonts-jetbrains-mono ttf-jetbrains-mono
	sudo pacman --needed --noconfirm -S ttf-font-awesome ttf-hack ttf-fira-code ttf-iosevka-nerd ttf-material-design-iconic-font noto-fonts-emoji
	sudo pacman --needed --noconfirm -S ttf-meslo-nerd-font-powerlevel10k ttf-ms-fonts ttf-ubuntu-font-family fontconfig
	yay --needed --noconfirm -S ttf-proggy-clean noto-color-emoji-fontconfig
	fc-cache

	echo -e "\n[*] Setting Zsh as default shell."
	chsh -s /bin/zsh
	sudo chsh -s /bin/zsh
	cat <<-EOF
		[*3*] Still installing packages.

		[*] Do you want to install optional, but useful programs? (VSCodium, LibreOffice, Dev tools, Apps)

		[1] yes
		[2] no

	EOF

	read -p "[?] Select option: "

	if [[ $REPLY == "1" ]]; then

		## communicating
		sudo pacman --needed --noconfirm -S discord drawio-desktop

		## Desktop Apps
		sudo pacman --needed --noconfirm -S libreoffice-fresh gimp obsidian

		# dev
		yay --needed --noconfirm -S visual-studio-code-bin docker docker-compose

		## go
		sudo pacman --needed --noconfirm -S go hugo ollama protobuf syncthing rsync

    ## py
    sudo pacman --needed --noconfirm -S python-pip python-pipx

		## ts
		yay --needed --noconfirm -S nvm npm deno

    ## zig/c
    sudo pacman --needed --noconfirm -S zig

		## virtual machines
		# sudo pacman --needed --noconfirm -S virt-manager

		## tools
		sudo pacman --needed --noconfirm -S net-tools ntfs-3g ventoy-bin
		yay -S --needed --noconfirm shell-color-scripts

	elif [[ $REPLY == "2" ]]; then
		echo -e "\n[*] Skipping."
	else
		echo -e "\n[!] Invalid option, exiting...\n"
		exit 1
	fi
}

install_packages
