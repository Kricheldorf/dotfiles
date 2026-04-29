#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# https://github.com/CyberShadow/aconfmgr/wiki/Whitelist-files
function IgnorePathsExcept() {
    # Ignore all paths in the given directory (first parameter)
    # that do not match the given whitelist (second parameter)

    local search_dir="${1%/}"
    shift
    local white_list=("$@")
    local find_args=()
    local ignore_path

    if [ ! -d "$search_dir" ]; then
        FatalError "The path ${search_dir} must be an existing directory\n"
    fi

    for ignore_path in "${white_list[@]}"; do
        local base="$ignore_path"
        if [[ "$ignore_path" =~ ^/ ]]; then
            FatalError "The path ${ignore_path} in the whitelist is not relative to the directory ${search_dir}\n"
        fi
        # Add all base paths to the argument list as well, otherwise
        # -prune will prevent us from reaching the whitelisted files.
        while [ "$base" != '.' ]; do
            find_args+=(-path "$search_dir/$base" -o)
            base="$(dirname "$base")"
        done
    done

    # Find everything except the given whitelist and the directory
    # being searched from
    find "$search_dir" -not \( "${find_args[@]}" -path "$search_dir" \) -prune | \
        while read -r file; do
            if [[ -d "$file" ]]; then
                IgnorePath "$file/*"
            fi
            IgnorePath "$file"
        done
}

function SystemdEnable() {
    local service=$1
    if sudo systemctl enable --now ${service}; then
        log_success "Systemd: ${service} service enabled and started"
    else
        log_error "Systemd: ${service} service failed to enable/start"
    fi
}
