#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm sassc

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package themix-gui-git
make-aur-package themix-theme-oomox-git
make-aur-package themix-icons-archdroid-git
make-aur-package themix-icons-gnome-colors-git
make-aur-package themix-icons-numix-git
make-aur-package themix-icons-papirus-git
make-aur-package themix-export-spotify-git
make-aur-package themix-import-images-git
make-aur-package themix-plugin-base16-git

