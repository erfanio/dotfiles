#!/usr/bin/env bash

echo "Install necessary packages"
sudo pacman -Sy waybar sway swaylock swayidle powerline-fonts htop alacritty dunst i3-wm waybar bemenu-wayland
echo "TODO install light, clipman via AUR"

echo "Install source code pro fonts"
git clone https://github.com/adobe-fonts/source-code-pro.git ~/.fonts/source-code-pro

echo "Creating a new SSH key"
ssh-keygen -t rsa -b 4096 -a 100

echo "Link sway config"
ln -v -s ~/dotfiles/waybar ~/.config/waybar
ln -v -s ~/dotfiles/sway ~/.config/sway
