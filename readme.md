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

##### Getting started (I'll nix it some day, or not)

1. Install preferred distro (the dotfiles are set to work with Arch based distros but can work with other if tweaked)
   1. Install i3wm (someday I'll move to hyprland or sway but wayland support is not really there for my use case)
2. Install softwares
   1. Browser (I currently use Edge, change configs accordingly if that's different)
   2. zsh and oh my zsh
   3. clone this repo and config (stow)
   4. read i3 config line by line and act accordingly with each config (some of them require actions before working properly)
      5. This step can take a long time xD
