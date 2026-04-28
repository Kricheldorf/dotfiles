### Dotfiles

This folder contains some of the dotfiles for my personal linux (and some macos) setup.

Use stow to symlink the dotfiles to your home directory.

```zsh
# Stow each folder separately and check if it's working
stow i3 --dotfiles
stow dunst --dotfiles
stow nvim --dotfiles
...
# Or stow all at once (not recommended)
stow -t ~ */ --dotfiles
```

There might be some useful information as comments in each config file. I find it easier
to have them there in their own context instead of here (also see the start of the files).

#### MANUAL install (not handled by stow)

Configs inside MANUAL follow a similar pattern to the stowed configs.

Example:

```zsh
MANUAL/keyd/etc/keyd/default.conf
```

Should be symlinked to:

```zsh
/etc/keyd/default.conf
```

##### Getting started (I'll nix it some day, or not)

1. Install preferred distro (the dotfiles are set to work with Arch based distros but can work with other if tweaked)
   1. CachyOS Hyperland
2. Install softwares
   1. clone this repo and config (stow)
   2. `aconfmgr save`
   3. `aconfmgr apply`
