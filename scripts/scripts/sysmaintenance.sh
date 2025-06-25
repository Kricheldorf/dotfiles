# Script from kurealnum on https://github.com/kurealnum/dotfiles/blob/main/.config/scripts/sysmaintenance.sh

# This code is almost entirely taken from Mr. Cejas's blog: https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/

source $HOME/scripts/news.sh

news

read -p "Update system? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 0
fi

echo "Updating system"
yay -Syu

echo "Clearing pacman cache"
pacman_cache_space_used="$(du -sh /var/cache/pacman/pkg/)"
paccache -r
echo "Space saved: $pacman_cache_space_used"

echo "Removing orphan packages"
yay -Qdtq | yay -Rns -

echo "Clearing ~/.cache"
home_cache_used="$(du -sh ~/.cache)"
rm -rf ~/.cache/
echo "Spaced saved: $home_cache_used"

echo "Clearing system logs"
journalctl --vacuum-time=7d

rm -rf ~/Code/shipix/shipix-platform/apps/shipix-app/.next
cd ~/Code/shipix/shipix-platform && npx nx reset

