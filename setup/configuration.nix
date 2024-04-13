  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  # Sway
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };



  # Enable sound with pipewire.
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zizou = {
    isNormalUser = true;
    description = "zizou";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };




  environment.systemPackages = with pkgs; [
    kitty
    obsidian
    discord
    vscode
    postman
    vivaldi
    syncthing
    git
    go
    python3
    python311Packages.pillow
    poetry
    nodejs
    yarn
    bun
    nodePackages.typescript-language-server
    jdk
    maven
    rustup
    gcc
    ripgrep
    tldr
    hugo
    protobuf
    ollama
    gdu
    zoxide
    starship
    lazygit
    zip
    unzip
    which
    wget
    man
    jq
    htop
    fd
    gnumake
    eza
    bat
    curl
    file
    entr
    inetutils
    iotop
    wob
    wl-clipboard
    wf-recorder
    wdisplays
    wofi
    waybar
    dbus
    wayland
    xdg-utils
    glib
    swaylock
    swayidle
    grim
    slurp
    swaybg
    light
    swappy
    xwayland
    tesseract
    wl-mirror
    xwaylandvideobridge
    swaynotificationcenter
    cliphist
    nwg-look
    emote
    gnome-extension-manager
    brightnessctl
    pamixer
    wlogout
    gparted
    gammastep
    upower
    tlp
    gruvbox-gtk-theme
    cmus
    playerctl
    mpv
    alsa-utils
    pavucontrol
    imv
    feh
    networkmanagerapplet
    blueman
    ntfs3g
    nettools
    transmission-gtk
    texliveFull
    adw-gtk3
    bibata-cursors
    papirus-icon-theme
  ];

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.blueman.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  services.gnome.gnome-keyring.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  hardware.bluetooth.settings = { General = { Experimental = true; }; };
  hardware.bluetooth.powerOnBoot = true;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  home.packages = with pkgs; [
    neofetch
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg


    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];




