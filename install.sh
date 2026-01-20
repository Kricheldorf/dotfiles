#!/bin/zsh

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NO_COLOR='\033[0m'


# TODO: Remove this variable after post-install tasks are automated and implement a better solution
TODO_DONE=true

log_info() {
    echo -e "${BLUE}[INFO]${NO_COLOR} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NO_COLOR} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NO_COLOR} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NO_COLOR} $1"
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root"
        exit 1
    fi
}

check_arch() {
    if ! command -v pacman &> /dev/null; then
        log_error "This script is designed for Arch Linux (pacman not found)"
        exit 1
    fi
}

update_system() {
    log_info "Updating system packages..."
    sudo pacman -Syu --noconfirm
    log_success "System updated"
}

create_directories() {
    log_info "Creating necessary directories..."
    
    local dirs=("$HOME/Code" "$HOME/Installations")
    
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            log_success "Created directory: $dir"
        else
            log_info "Directory already exists: $dir"
        fi
    done
}

setup_dotfiles() {
    log_info "Setting up dotfiles..."
    
    cd "$HOME"
    if [[ ! -d "dotfiles" ]]; then
        if git clone https://github.com/Kricheldorf/dotfiles.git; then
            log_success "Dotfiles cloned successfully"
        else
            log_error "Failed to clone dotfiles"
        fi
    else
        log_info "Dotfiles directory already exists"
    fi
}

install_packages() {
    log_info "Installing packages..."

    local packages=(
        base-devel git kitty fzf zsh brave-bin stow neovim lazygit zsh-autocomplete zsh-autosuggestions
        starship postgresql bat bat-extras eza ncdu yazi keyd dbeaver nvm git-delta docker docker-compose
        spotify-player perl-image-exiftool wl-clipboard dunst hyprpolkitagent ly zoxide pnpm
        fuse2 hyprlock seahorse gnome-keyring tmux resvg 7zip satty hyprshot
        hyprpicker swaybg hyprland obsidian libappindicator nwg-look
    )
    local aur_packages=(
        vicinae-bin insync tmux-plugin-manager slack-desktop ente-auth-bin
    )
 
    log_info "Installing ${#packages[@]} packages: ${packages[*]}"
    if sudo pacman -S --noconfirm --needed "${packages[@]}"; then
        log_success "Packages installed successfully"
    else
        log_error "Failed to install some packages"
        return 1
    fi

    log_info "Installing ${#aur_packages[@]} AUR packages: ${aur_packages[*]}"
    if paru -S --needed --batchinstall --sudoloop "${aur_packages[@]}"; then
        log_success "AUR packages installed successfully"
    else
        log_error "Failed to install some AUR packages"
        return 1
    fi
}

setup_oh_my_zsh() {
    log_info "Setting up Oh My Zsh..."
 
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        if sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
            log_success "Oh My Zsh installed"
        else
            log_error "Failed to install Oh My Zsh"
        fi
    else
        log_info "Oh My Zsh already installed"
    fi
    
    local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    if [[ ! -d "$plugin_dir" ]]; then
        log_info "Installing zsh-autosuggestions plugin..."
        if git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir"; then
            log_success "zsh-autosuggestions installed"
        else
            log_error "Failed to install zsh-autosuggestions"
        fi
    else
        log_info "zsh-autosuggestions already installed"
    fi
}

setup_keyd() {
    log_info "Setting up keyd configuration..."
    
    local keyd_config="$HOME/dotfiles/MANUAL/keyd/etc/keyd/default.conf"
    local target_config="/etc/keyd/default.conf"
    
    if [[ -f "$keyd_config" ]]; then
        if [[ ! -d "$target_config" ]]; then
            log_info "keyd already configured"
            return 0
        fi

        sudo mkdir -p /etc/keyd
        if sudo cp -s "$keyd_config" "$target_config"; then
            log_success "Keyd configuration copied"
            
            if sudo systemctl enable keyd --now; then
                log_success "Keyd service enabled and started"
            else
                log_warning "Failed to enable/start keyd service"
            fi
        else
            log_error "Failed to copy keyd configuration"
        fi
    else
        log_warning "Keyd configuration file not found in dotfiles"
    fi
}

setup_nodejs() {
    log_info "Setting up Node.js..."
    
    if command -v nvm &> /dev/null; then
        log_info "Installing latest LTS Node.js..."
        nvm install --lts
        nvm use --lts
        log_success "Node.js LTS installed and activated"
    else
        log_warning "nvm not found. Please install nvm manually or restart your shell"
    fi
}

setup_docker() {
    log_info "Setting up Docker..."
    
    sudo gpasswd -a "$(whoami)" docker
    log_success "User added to docker group"
    
    if sudo systemctl enable docker.socket --now; then
        log_success "Docker service enabled and started"
    else
        log_error "Failed to enable/start Docker service"
    fi
}

setup_shell() {
    log_info "Setting up shell..."
    
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        log_info "Changing default shell to zsh..."
        if chsh -s "$(which zsh)"; then
            log_success "Default shell changed to zsh"
            log_warning "Please restart your session to use zsh"
        else
            log_error "Failed to change default shell"
        fi
    else
        log_info "Zsh is already the default shell"
    fi


    [[ -f "$HOME/.zshrc" ]] && rm "$HOME/.zshrc"

    if [[ -d "$HOME/dotfiles" ]]; then
        log_info "Configuring zsh..."
        cd "$HOME/dotfiles"
        stow zsh --dotfiles
        log_success "Zsh configured"
    else
        log_error "Cannot configure zsh: dotfiles directory not found"
    fi
}

setup_keyboard_layout() {
    log_info "Setting up keyboard layout..."

    if cat /etc/X11/xorg.conf.d/00-keyboard.conf | grep -q "Layout"; then
        log_info "Keyboard layout already set"
    else
        log_info "Setting keyboard layout..."
        sudo localectl set-x11-keymap us "" altgr-intl
        sudo localectl set-keymap us-acentos
        sudo localectl set-locale LANG=en_US.UTF-8 \
          LC_NUMERIC=pt_BR.UTF-8 \
          LC_TIME=pt_BR.UTF-8 \
          LC_MONETARY=pt_BR.UTF-8 \
          LC_PAPER=pt_BR.UTF-8 \
          LC_NAME=pt_BR.UTF-8 \
          LC_ADDRESS=pt_BR.UTF-8 \
          LC_TELEPHONE=pt_BR.UTF-8 \
          LC_MEASUREMENT=pt_BR.UTF-8 \
          LC_IDENTIFICATION=pt_BR.UTF-8
        log_success "Keyboard layout set"
    fi
}

post_install() {
    if [[ "$TODO_DONE" == false ]]; then
        display_todo
        return 0
    fi

    log_info "TODO-DONE variable set to true. Running post-installation tasks..."
    # TODO: Write post-installation tasks
}

display_todo() {
    log_info "Post-installation tasks to complete manually:"
    echo "* Install WebStorm IDE"
    echo "* Configure SSH key for GitHub:"
    echo "   ssh-keygen -t ed25519 -C 'your_email@example.com'"
    echo "   ssh-add ~/.ssh/id_ed25519"
    echo "   cat ~/.ssh/id_ed25519.pub # Add to GitHub"
    # TODO: Automate in an interactive post-install script
    echo "* Update dotfiles origin url. TODO: Automate in an interactive post-install script"
    echo "   cd $HOME/dotfiles && git remote set-url origin git@github.com:Kricheldorf/dotfiles.git"
    echo "* Clone work repositories"
    # TODO: Automate in an interactive post-install script
    echo "* Configure Git identity: TODO: Automate in an interactive post-install script"
    echo "   git config --global user.email 'your_email@example.com'"
    echo "   git config --global user.name 'Your Name'"
    echo "* Update MANUAL configs from the dotfiles repo"
    echo "* Update browser settings (manual). TODO: Create browser settings todo list with settings to change and services to log in"
    echo "* Change /etc/systemd/logind.conf (set HandleLidSwitchDocked=suspend)"
    echo "* Restart your session to apply all changes"
    echo "* Update TODO-DONE variable in the installation script and run it again"
}

main() {
    log_info "Starting system setup..."
    
    check_root
    check_arch
    
    update_system
    create_directories
    setup_dotfiles
    install_packages
    setup_oh_my_zsh
    setup_keyd
    setup_nodejs
    setup_docker
    setup_shell
    
    post_install
    
    log_success "Setup completed successfully!"
    log_info "Restart your session to ensure all changes take effect."
}

main "$@"

