IgnorePath '/usr/*' # system files
IgnorePath '/var/*' # system files
IgnorePath '/boot/*' # system files
IgnorePath '/opt/*' # system files
IgnorePath '/.snapshots/*' # system files

etc_white_list=(
  'keyd/*'
)
IgnorePathsExcept '/etc' "${etc_white_list[@]}"

# CachyOS base files

IgnorePackage accountsservice # D-Bus interface for user account query and manipulation
IgnorePackage alsa-firmware # Firmware binaries for loader programs in alsa-tools and hotplug firmware loader
IgnorePackage alsa-plugins # Additional ALSA plugins
IgnorePackage alsa-utils # Advanced Linux Sound Architecture - Utilities
IgnorePackage amd-ucode # Microcode update image for AMD CPUs
IgnorePackage arianna # EPub Reader for mobile devices
IgnorePackage base # Minimal package set to define a basic Arch Linux installation
IgnorePackage base-devel # Basic tools to build Arch Linux packages
IgnorePackage bash-completion # Programmable completion for the bash shell
IgnorePackage bind # A complete, highly portable implementation of the DNS protocol
IgnorePackage btrfs-assistant # An application for managing BTRFS subvolumes and Snapper snapshots
IgnorePackage btrfs-progs # Btrfs filesystem utilities
IgnorePackage cachyos-fish-config # Fish configuration of CachyOS
IgnorePackage cachyos-gaming-applications # Common Applications used for Gaming
IgnorePackage cachyos-gaming-meta # Meta package for Gaming dependencies
IgnorePackage cachyos-grub-theme # Grub2 Theme for CachyOS
IgnorePackage cachyos-hello # Welcome screen for CachyOS
IgnorePackage cachyos-hooks # CachyOS libalpm hooks
IgnorePackage cachyos-kernel-manager # Simple kernel manager
IgnorePackage cachyos-keyring # CachyOS keyring
IgnorePackage cachyos-micro-settings # CachyOS micro settings
IgnorePackage cachyos-mirrorlist # CachyOS repository mirrorlist
IgnorePackage cachyos-packageinstaller # Simple Software Application Package Installer for CachyOS which helps setting up & installing applications
IgnorePackage cachyos-plymouth-bootanimation # CachyOS Bootanimation (new)
IgnorePackage cachyos-rate-mirrors # CachyOS - Rate mirrors service
IgnorePackage cachyos-settings # CachyOS - Settings
IgnorePackage cachyos-v3-mirrorlist # CachyOS repository mirrorlist
IgnorePackage cachyos-v4-mirrorlist # CachyOS repository mirrorlist
IgnorePackage cachyos-zsh-config # Zsh configuration for CachyOS
IgnorePackage cantarell-fonts # Humanist sans serif font
IgnorePackage catch2 # Modern, C++-native, header-only, test framework for unit-tests, TDD and BDD
IgnorePackage chwd # CachyOS Hardware Detection Tool
IgnorePackage cmake # A cross-platform open-source make system
IgnorePackage code # The Open Source build of Visual Studio Code (vscode) editor
IgnorePackage cpupower # Linux kernel tool to examine and tune power saving related features of your processor
IgnorePackage cryptsetup # Userspace setup tool for transparent encryption of block devices using dm-crypt
IgnorePackage device-mapper # Device mapper userspace library and tools
IgnorePackage dhclient # A standalone DHCP client from the dhcp package
IgnorePackage discord # All-in-one voice and text chat for gamers
IgnorePackage dmidecode # Desktop Management Interface table related utilities
IgnorePackage dmraid # Device mapper RAID interface
IgnorePackage dnsmasq # Lightweight, easy to configure DNS forwarder and DHCP server
IgnorePackage dosfstools # DOS filesystem utilities
IgnorePackage duf # Disk Usage/Free Utility
IgnorePackage e2fsprogs # Ext2/3/4 filesystem utilities
IgnorePackage efibootmgr # Linux user-space application to modify the EFI Boot Manager
IgnorePackage efitools # Tools for manipulating UEFI secure boot platforms
IgnorePackage egl-wayland # EGLStream-based Wayland external platform
IgnorePackage ethtool # Utility for controlling network drivers and hardware
IgnorePackage ex-vi-compat # The ex and vi commands based on vim's compatibility modes
IgnorePackage exfatprogs # exFAT filesystem userspace utilities for the Linux Kernel exfat driver
IgnorePackage f2fs-tools # Tools for Flash-Friendly File System (F2FS)
IgnorePackage fastfetch # A feature-rich and performance oriented neofetch like system information tool
IgnorePackage ffmpegthumbnailer # Lightweight video thumbnailer that can be used by file managers
IgnorePackage firefox # Fast, Private & Safe Web Browser
IgnorePackage fsarchiver # Safe and flexible file-system backup and deployment tool
IgnorePackage glaze # An Extremely fast, In-Memory JSON and Interface Library for Modern C++
IgnorePackage grub # GNU GRand Unified Bootloader (2)
IgnorePackage grub-btrfs-support # Support package for enabling grub-btrfs support
IgnorePackage grub-hook # Pacman hook to update GRUB after a kernel update
IgnorePackage gst-libav # Multimedia graph framework - libav plugin
IgnorePackage gst-plugin-pipewire # Multimedia graph framework - pipewire plugin
IgnorePackage gst-plugins-bad # Multimedia graph framework - bad plugins
IgnorePackage gst-plugins-ugly # Multimedia graph framework - ugly plugins
IgnorePackage haveged # Entropy harvesting daemon using CPU timings
IgnorePackage hdparm # A shell utility for manipulating Linux IDE drive/driver parameters
IgnorePackage hwdetect # Hardware detection script with loading modules and mkinitcpio.conf
IgnorePackage hwinfo # Hardware detection tool from openSUSE
IgnorePackage inetutils # A collection of common network programs
IgnorePackage iptables # Linux kernel packet control tool (using nft interface)
IgnorePackage iptables-nft # Linux kernel packet control tool (using nft interface)
IgnorePackage iwd # Internet Wireless Daemon
IgnorePackage jfsutils # JFS filesystem utilities
IgnorePackage less # A terminal based program for viewing text files
IgnorePackage lib32-nvidia-utils # NVIDIA drivers utilities (32-bit)
IgnorePackage lib32-opencl-nvidia # OpenCL implemention for NVIDIA (32-bit)
IgnorePackage lib32-vulkan-icd-loader # Vulkan Installable Client Driver (ICD) Loader (32-bit)
IgnorePackage libdvdcss # Portable abstraction library for DVD decryption
IgnorePackage libgsf # Extensible I/O abstraction library for dealing with structured file formats
IgnorePackage libinput-tools # Input device management and event handling library (debug utilities)
IgnorePackage libopenraw # Library for decoding RAW files
IgnorePackage libva-nvidia-driver # VA-API implementation that uses NVDEC as a backend
IgnorePackage libwnck3 # Library to manage X windows and workspaces (for e.g. pagers or tasklists)
IgnorePackage linux-cachyos # The Linux EEVDF + LTO + AutoFDO + Propeller Cachy Sauce Kernel by CachyOS with other patches and improvements. kernel and modules
IgnorePackage linux-cachyos-headers # Headers and scripts for building modules for the Linux EEVDF + LTO + AutoFDO + Propeller Cachy Sauce Kernel by CachyOS with other patches and improvements. kernel
IgnorePackage linux-cachyos-lts # The Linux BORE + Cachy Sauce Kernel by CachyOS with other patches and improvements - Long Term Service kernel and modules
IgnorePackage linux-cachyos-lts-headers # Headers and scripts for building modules for the Linux BORE + Cachy Sauce Kernel by CachyOS with other patches and improvements - Long Term Service kernel
IgnorePackage linux-cachyos-lts-nvidia-open # nvidia open modules of 595.58.03 driver for the linux-cachyos-lts kernel
IgnorePackage linux-cachyos-nvidia-open # nvidia open modules of 595.58.03 driver for the linux-cachyos kernel
IgnorePackage linux-firmware # Firmware files for Linux - Default set
IgnorePackage logrotate # Rotates system logs automatically
IgnorePackage lsb-release # LSB version query program
IgnorePackage lsscsi # A tool that lists devices connected via SCSI and its transports
IgnorePackage lvm2 # Logical Volume Manager 2 utilities
IgnorePackage man-db # A utility for reading man pages
IgnorePackage man-pages # Linux man pages
IgnorePackage mdadm # A tool for managing/monitoring Linux md device arrays, also known as Software RAID
IgnorePackage meld # Compare files, directories and working copies
IgnorePackage mesa-utils # Essential Mesa utilities
IgnorePackage micro # Modern and intuitive terminal-based text editor
IgnorePackage mkinitcpio # Modular initramfs image creation utility
IgnorePackage modemmanager # Mobile broadband modem management service
IgnorePackage mtools # A collection of utilities to access MS-DOS disks
IgnorePackage nano # Pico editor clone with enhancements
IgnorePackage nano-syntax-highlighting # Nano editor syntax highlighting enhancements
IgnorePackage nfs-utils # Support programs for Network File Systems
IgnorePackage nilfs-utils # A log-structured file system supporting continuous snapshotting (userspace utils)
IgnorePackage ninja # Small build system with a focus on speed
IgnorePackage nss-mdns # glibc plugin providing host name resolution via mDNS
IgnorePackage ntp # Network Time Protocol reference implementation
IgnorePackage nvidia-settings # Tool for configuring the NVIDIA graphics driver
IgnorePackage nvidia-utils # NVIDIA drivers utilities
IgnorePackage octopi # A powerful Pacman frontend using Qt libs
IgnorePackage opencl-nvidia # OpenCL implemention for NVIDIA
IgnorePackage openssh # SSH protocol implementation for remote login, command execution and file transfer
IgnorePackage os-prober # Utility to detect other OSes on a set of drives
IgnorePackage pacman-contrib # Contributed scripts and tools for pacman systems
IgnorePackage paru # Feature packed AUR helper
IgnorePackage pipewire-alsa # Low-latency audio/video router and processor - ALSA configuration
IgnorePackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
IgnorePackage pkgfile # A tool to search for files in official repository packages
IgnorePackage plocate # Alternative to locate, faster and compatible with mlocate's database.
IgnorePackage plymouth # Graphical boot splash screen
IgnorePackage poppler-glib # Poppler glib bindings
IgnorePackage power-profiles-daemon # Makes power profiles handling available over D-Bus
IgnorePackage pulumi # Modern Infrastructure as Code
IgnorePackage pv # A terminal-based tool for monitoring the progress of data through a pipeline
IgnorePackage python # The Python programming language
IgnorePackage python-defusedxml # XML bomb protection for Python stdlib modules
IgnorePackage python-packaging # Core utilities for Python packages
IgnorePackage python-weasyprint # Utility to render HTML and CSS to PDF
IgnorePackage rebuild-detector # Detects which packages need to be rebuilt
IgnorePackage reflector # A Python 3 module and script to retrieve and filter the latest Pacman mirror list.
IgnorePackage rsync # A fast and versatile file copying tool for remote and local files
IgnorePackage rtkit # Realtime Policy and Watchdog Daemon
IgnorePackage s-nail # Environment for sending and receiving mail
IgnorePackage sddm # QML based X11 and Wayland display manager
IgnorePackage sg3_utils # Generic SCSI utilities
IgnorePackage smartmontools # Control and monitor S.M.A.R.T. enabled ATA and SCSI Hard Drives
IgnorePackage snapper # A tool for managing BTRFS and LVM snapshots
IgnorePackage sof-firmware # Sound Open Firmware
IgnorePackage starship # The cross-shell prompt for astronauts
IgnorePackage sudo # Give certain users the ability to run some commands as root
IgnorePackage sway # Tiling Wayland compositor and replacement for the i3 window manager
IgnorePackage sysfsutils # System Utilities Based on Sysfs
IgnorePackage texinfo # GNU documentation system for on-line information and printed output
IgnorePackage ufw # Uncomplicated and easy to use CLI tool for managing a netfilter firewall
IgnorePackage upower # Abstraction for enumerating power devices, listening to device events and querying history and statistics
IgnorePackage usb_modeswitch # Activating switchable USB devices on Linux.
IgnorePackage usbutils # A collection of USB tools to query connected USB devices
IgnorePackage uwsm # A standalone Wayland session manager
IgnorePackage vulkan-icd-loader # Vulkan Installable Client Driver (ICD) Loader
IgnorePackage wget # Network utility to retrieve files from the web
IgnorePackage which # A utility to show the full path of commands
IgnorePackage wine-mono # Wine's built-in replacement for Microsoft's .NET Framework
IgnorePackage wireless-regdb # Central Regulatory Domain Database
IgnorePackage wireplumber # Session / policy manager implementation for PipeWire
IgnorePackage wpa_supplicant # A utility providing key negotiation for WPA wireless networks
IgnorePackage xf86-input-libinput # Generic input driver for the X.Org server based on libinput
IgnorePackage xfsprogs # XFS filesystem utilities
IgnorePackage xl2tpd # an open source implementation of the L2TP maintained by Xelerance Corporation
IgnorePackage xorg-server # Xorg X server
IgnorePackage xorg-xdpyinfo # Display information utility for X
IgnorePackage xorg-xinit # X.Org initialisation program
IgnorePackage xorg-xinput # Small commandline tool to configure devices
IgnorePackage xorg-xkill # Kill a client by its X resource
IgnorePackage xorg-xrandr # Primitive command line interface to RandR extension
IgnorePackage zsh-autocomplete # Real-time type-ahead completion for Zsh

IgnorePackage --foreign bolt-launcher # Free open-source third-party implementation of the Jagex Launcher
