{ config, pkgs, lib, ... }:{

# Allows Proprietary Packages
nixpkgs.config.allowUnfree = true;

# System Packages
environment.systemPackages = with pkgs; [
    #Internet & Networking
    iwd
    openconnect
    dig
    networkmanagerapplet
    firefox
    wireshark

    #Code & Notes
    git
    gh
    gnupg
    python3
    obsidian
    (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
            ms-azuretools.vscode-docker
            ms-python.python
            ms-vscode-remote.remote-ssh
            github.vscode-github-actions
            redhat.vscode-yaml
            eamodio.gitlens
        ];
    })

    # Kubernetes, Containers, & General Virtualization
    docker
    kubectl
    kubernetes-helm
    talosctl
    kubevirt
    kustomize
    terraform
    virt-manager
    k9s

    # Terminal & Hardware Control
    pulseaudio
    fastfetch
    btop
    pinentry-curses
    wl-clipboard
    wlogout
    pavucontrol
    grim
    slurp
    ghostty
    fish
    wget
    blueman
    kitty

    # Dotfile & UI Customization
    wofi
    waybar
    mako
    xfce.thunar
    adwaita-icon-theme
    gnome-themes-extra

    # Wayland
    wayland
    wayland-utils

    # Other
    gimp3
    slack
    protonup-qt
    discord
    obs-studio
    jq
];

# Common Nerd Fonts
fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    font-awesome
];

}
