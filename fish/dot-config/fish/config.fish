source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   # fastfetch -s Title:Separator:Uptime:Memory:Swap:Disk -l none
end

# PATH configuration
fish_add_path $HOME/bin $HOME/.local/bin /usr/local/bin $HOME/.cargo/bin "$HOME/Installations/Webstorm/bin" "/usr/local/opt/postgresql@16/bin" "$HOME/scripts" $GOPATH/bin

zoxide init fish | source

# Auto-cd to default work directory if set
if test -n "$DEFAULT_WORK_DIR"; and test "$PWD" = "$HOME"
    cd "$DEFAULT_WORK_DIR"
end

set -gx EDITOR nvim
set -gx VISUAL nvim

set -g async_prompt_functions _pure_prompt_git

# Aliases
abbr -a dev "tmux new -A -s 0"
abbr -a lg "lazygit"
abbr -a vim "nvim"
abbr -a ncdu "ncdu -t8"
abbr -a gco "git checkout"
function ggpush
    git push origin (git rev-parse --abbrev-ref HEAD)
end

function ggpull
    git pull origin (git rev-parse --abbrev-ref HEAD)
end

# Diff tool aliases
abbr -a icat "kitten icat"
abbr -a kdiff "kitten diff"
abbr -a ndiff "nvim -d"

# Work project aliases
abbr -a zq "cd ~/Code/quicargo/quicargo-platform"
abbr -a zs "cd ~/Code/shipix/shipix-platform"
abbr -a migrate "npm install && npm run db:migration:run"
abbr -a sdb "cd ~/Code/shipix/shipix-platform && npm run docker:database:up"
abbr -a sapi "cd ~/Code/shipix/shipix-platform && npm run start:api:dev"
abbr -a sapp "cd ~/Code/shipix/shipix-platform && npm run start:app:dev"

# # Pacman aliases (Arch Linux)
abbr -a rmpkg "sudo pacman -Rsn"
abbr -a cleanch "sudo pacman -Scc"
abbr -a fixpacman "sudo rm /var/lib/pacman/db.lck"
abbr -a c "claude"

# Functions
function n
    nvim .
end

function zsl
    cd ~/Code/shipix/shipix-platform && lazygit
end

function zsn
    cd ~/Code/shipix/shipix-platform && nvim .
end

function gotest
    set -l branch $argv[1]
    git fetch origin $branch:$branch
    git checkout $branch
end

function export_stash
    set -l stash_num $argv[1]
    git stash show stash@{$stash_num} -p > patch_$stash_num
end

function import_stash
    git apply $argv[1]
end

function rtldr
    curl cheat.sh/"$argv[1]"
end

function mkcd
    mkdir -p "$argv[1]" && cd "$argv[1]"
end

function extract
    switch "$argv[1]"
        case '*.tar.gz' '*.tgz'
            tar xzf "$argv[1]"
        case '*.tar.bz2' '*.tbz2'
            tar xjf "$argv[1]"
        case '*.tar.xz' '*.txz'
            tar xJf "$argv[1]"
        case '*.tar'
            tar xf "$argv[1]"
        case '*.zip'
            unzip "$argv[1]"
        case '*.7z'
            7z x "$argv[1]"
        case '*.rar'
            unrar x "$argv[1]"
        case '*.gz'
            gunzip "$argv[1]"
        case '*.bz2'
            bunzip2 "$argv[1]"
        case '*.xz'
            unxz "$argv[1]"
        case '*'
            echo "Unknown format: $argv[1]"
    end
end

function yank_line_to_clipboard
    set -l content (commandline -b)
    echo -n "$content" | wl-copy
end

function paste_from_clipboard
    set -l content (wl-paste)
    commandline -i "$content"
end

function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M default yy yank_line_to_clipboard
    bind -M default p paste_from_clipboard
    bind -M insert \cy yank_line_to_clipboard
end

function gwt
    if test (count $argv) -eq 0
        echo "Usage: gwt <branch-name>"
        return 1
    end

    set branch $argv[1]
    set repo_root (git rev-parse --show-toplevel 2>/dev/null)

    if test $status -ne 0
        echo "Not inside a git repository"
        return 1
    end

    set worktree_path (dirname $repo_root)/$branch

    if git show-ref --verify --quiet refs/heads/$branch
        git worktree add $worktree_path $branch
    else
        git worktree add $worktree_path -b $branch
    end

    if test $status -ne 0
        echo "Failed to create worktree"
        return 1
    end

    if test -d $repo_root/node_modules
        ln -s $repo_root/node_modules $worktree_path/node_modules
        echo "Symlinked node_modules from $repo_root"
    end

    echo "Worktree ready at $worktree_path"
end

function pom
    set split $POMO_SPLIT
    if ! test -n "$split"
        set split $(gum choose "25/5" "50/10" "all done" --header "Choose a pomodoro split.")
    end

    switch $split
        case 25/5
            set work 25m
            set break 5m
        case 50/10
            set work 50m
            set break 10m
        case 'all done'
            return
    end

    timer $work && notify-send 'Work Timer is up! Take a Break 😊' 'Pomodoro' --icon=dialog-information 

    gum confirm "Ready for a break?" && timer $break && terminal-notifier -message Pomodoro \
            -title 'Break is over! Get back to work 😬' \
        -sound Crystal \
        || pom
end
