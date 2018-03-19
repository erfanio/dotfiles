#!/usr/bin/env bash

echo "Install yaourt"
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
rm yaourt package-query -rf

echo "Symlink arch specific configs"
ln -v -s ~/dotfiles/i3 ~/.config/i3
ln -v -s ~/dotfiles/.xinitrc ~/.xinitrc
ln -v -s ~/dotfiles/.Xresources ~/.Xresources

echo "Creating a new SSH key"
ssh-keygen -t rsa -b 4096 -o -a 100

echo "You need to download something to .fehbg.jpg"
