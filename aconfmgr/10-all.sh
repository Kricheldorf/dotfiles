# 10-all.sh — Core system packages and user packages for current workflow (build upon CachyOS)
# TODO: Break into multiple files


# 10-base.sh — Core system packages and base packages for current workflow

AddPackage 7zip # File archiver for extremely high compression
AddPackage awesome-terminal-fonts # fonts/icons for powerlines
AddPackage bat-extras # Bash scripts that integrate bat with various command line tools
AddPackage bluetui # TUI for managing bluetooth devices
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-hid2hci # Put HID proxying bluetooth HCI's into HCI mode
AddPackage bluez-libs # Deprecated libraries for the bluetooth protocol stack
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
AddPackage btop # A monitor of system resources, bpytop ported to C++
AddPackage diffutils # Utility programs used for creating patch files
AddPackage fuse2 # Interface for userspace programs to export a filesystem to the Linux kernel
AddPackage git-delta # syntax-highlighting pager for git and diff output
AddPackage git # the fast distributed version control system
AddPackage go # core compiler tools for the go programming language
AddPackage netctl # Profile based systemd network management
AddPackage networkmanager # Network connection manager and user applications
AddPackage networkmanager-openvpn # NetworkManager VPN plugin for OpenVPN (with GUI)
AddPackage noto-color-emoji-fontconfig # Fontconfig to enable Noto Color Emoji fonts where emojis can be displayed
AddPackage noto-fonts-cjk # Google Noto CJK fonts
AddPackage noto-fonts-emoji # Google Noto Color Emoji font
AddPackage noto-fonts # Google Noto TTF fonts
AddPackage perl # A highly capable, feature-rich programming language
AddPackage perl-image-exiftool # Read and write EXIF information
AddPackage playerctl # mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others.
AddPackage resvg # SVG rendering library and CLI
AddPackage ripgrep # A search tool that combines the usability of ag with the raw speed of grep
AddPackage tmux # Terminal multiplexer
AddPackage ttf-bitstream-vera # Bitstream Vera fonts.
AddPackage ttf-dejavu # Font family based on the Bitstream Vera Fonts with a wider range of characters
AddPackage ttf-liberation # Font family which aims at metric compatibility with Arial, Times New Roman, and Courier New
AddPackage ttf-meslo-nerd # Patched font Meslo LG from nerd fonts library
AddPackage ttf-opensans # Sans-serif typeface commissioned by Google
AddPackage unrar # The RAR uncompression program
AddPackage unzip # For extracting and viewing files in .zip archives
AddPackage vim # Vi Improved, a highly configurable, improved version of the vi text editor
AddPackage yazi # Blazing fast terminal file manager written in Rust, based on async I/O
AddPackage zoxide # A smarter cd command for your terminal

# AUR packages

AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign tmux-plugin-manager # tpm - Tmux Plugin Manager
AddPackage --foreign ttf-ms-fonts # Core TTF Fonts from Microsoft


# 20-desktop.sh — Desktop environment

AddPackage dolphin # KDE File Manager
AddPackage dunst # Customizable and lightweight notification-daemon
AddPackage gnome-keyring # stores passwords and encryption keys
AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprlock # hyprland’s GPU-accelerated screen locking utility
AddPackage hyprpicker # A wlroots-compatible Wayland color picker that does not suck
AddPackage hyprpolkitagent # Simple polkit authentication agent for Hyprland, written in QT/QML
AddPackage hyprshot # Hyprland screenshot utility
AddPackage libappindicator # Allow applications to extend a menu via Ayatana indicators in Unity, KDE or Systray
AddPackage ly # TUI display manager
AddPackage network-manager-applet # Applet for managing network connections
AddPackage nwg-look # GTK settings editor adapted to work on wlroots-based compositors
AddPackage pavucontrol # PulseAudio Volume Control
AddPackage polkit-kde-agent # Daemon providing a polkit authentication UI for KDE
AddPackage satty # Modern screenshot annotation tool, inspired by Swappy and Flameshot
AddPackage seahorse # GNOME application for managing PGP keys
AddPackage swaybg # Wallpaper tool for Wayland compositors
AddPackage waybar # Highly customizable Wayland bar for Sway and Wlroots based compositors
AddPackage wayland-protocols # Specifications of extended Wayland protocols
AddPackage wl-clipboard # Command-line copy/paste utilities for Wayland
AddPackage wmenu # Efficient dynamic menu for Wayland and wlroots based Wayland compositors
AddPackage wofi # launcher for wlroots-based wayland compositors
AddPackage xdg-desktop-portal # Desktop integration portals for sandboxed apps
AddPackage xdg-desktop-portal-hyprland # xdg-desktop-portal backend for hyprland
AddPackage xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
AddPackage xdg-user-dirs # Manage user directories like ~/Desktop and ~/Music
AddPackage xorg-xwayland # run X clients under wayland

# AUR packages

AddPackage --foreign vicinae-bin # Raycast like FOSS app on Linux


# 30-dev.sh — Development tools

AddPackage aws-cli-v2 # Universal Command Line Interface for Amazon Web Services (version 2)
AddPackage bats # Bash Automated Testing System
AddPackage csvlens # Command line csv viewer
AddPackage dbeaver # Free universal SQL Client for developers and database administrators (community edition)
AddPackage diffnav # git diff pager based on delta but with a file tree, à la GitHub
AddPackage docker-compose # Fast, isolated development environments using Docker
AddPackage docker # Pack, ship and run any application as a lightweight container
AddPackage fnm # Fast and simple Node.js version manager, built with Rust
AddPackage github-cli # The GitHub CLI
AddPackage lazydocker # A simple terminal UI for docker and docker-compose, written in Go with the gocui library.
AddPackage lazygit # Simple terminal UI for git commands
AddPackage neovim # Fork of Vim aiming to improve user experience, plugins, and GUIs
AddPackage tree-sitter-cli # CLI tool for developing, testing, and using Tree-sitter parsers
AddPackage zellij # A terminal multiplexer
AddPackage postgresql # Sophisticated object-relational DBMS

# AUR packages

AddPackage --foreign slack-desktop # Slack Desktop (Beta) for Linux
IgnorePackage --foreign gitflow-cjs # CJS Edition of the git extensions to provide high-level repository operations for Vincent Driessen's branching model.


# 40-apps.sh — Applications

AddPackage bitwarden # A secure and free password manager for all of your devices
AddPackage brave-bin # Web browser that blocks ads and trackers by default (binary release)
AddPackage hledger # Command-line interface for the hledger accounting system
AddPackage hledger-ui # Curses-style terminal interface for the hledger accounting system
AddPackage hledger-web # Web-based user interface for the hledger accounting system
AddPackage keyd # A key remapping daemon for linux
AddPackage kitty # a modern, hackable, featureful, opengl-based terminal emulator
AddPackage localsend # An open source cross-platform alternative to AirDrop
AddPackage ncdu # Disk usage analyzer with an ncurses interface
AddPackage obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
AddPackage okular # Document Viewer
AddPackage onlyoffice-bin # An office suite that combines text, spreadsheet and presentation editors
AddPackage spotify-player # A command driven spotify player
AddPackage stow # Manage installation of multiple softwares in the same directory tree
AddPackage syncthing # Open Source Continuous Replication / Cluster Synchronization Thing

# AUR packages

AddPackage --foreign ente-auth-bin # Ente two-factor authenticator.
AddPackage --foreign insync # An unofficial Dropbox, Google Drive, and OneDrive client that runs on Linux, with support for various desktops
AddPackage --foreign vial-appimage # Vial is an open-source cross-platform (Windows, Linux and Mac) GUI and a QMK fork for configuring your keyboard in real time, similar to VIA.

# 90-remove.sh - Apps to remove

RemovePackage asciinema # Record and share terminal sessions
RemovePackage code # The Open Source build of Visual Studio Code (vscode) editor
RemovePackage --foreign timer-bin # Timer is like sleep, but reports progress.
RemovePackage ghostty # Fast, native, feature-rich terminal emulator pushing modern features
RemovePackage glances # CLI curses-based monitoring tool
RemovePackage gradle # Powerful build system for the JVM
RemovePackage gum # A tool for glamorous shell scripts
RemovePackage nushell # A new type of shell
RemovePackage pnpm # Fast, disk space efficient package manager
RemovePackage television # A general purpose fuzzy finder for your terminal
