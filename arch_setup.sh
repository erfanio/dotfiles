#!/usr/bin/env bash

echo "install powerline font, it's needed for rendering tmux/zsh/vim themes"
curl -Lo .fonts/OTF/source-code-pro-powerline.otf --create-dirs https://raw.githubusercontent.com/powerline/fonts/master/SourceCodePro/Source%20Code%20Pro%20for%20Powerline.otf

echo "Install yaourt"
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm yaourt package-query -rf

echo "Symlink arch specific configs"
ln -v -s ~/dotfiles/i3 ~/.config/i3
ln -v -s ~/dotfiles/.xinitrc ~/.xinitrc
ln -v -s ~/dotfiles/.Xresources ~/.Xresources

echo "Creating a new SSH key"
ssh-keygen -t rsa -b 4096 -a 100

echo "Installing packages"
yay -Sy $(cat dotfiles/packages) --noconfirm

echo "Install i3-gnome"
git clone https://github.com/i3-gnome/i3-gnome.git
cd i3-gnome
sudo make install
cd ..

gsettings set org.gnome.gnome-flashback desktop false

echo "Setting up VPN"
cat >> /etc/systemd/system/openvpn-reconnect.service <<EOD
[Unit]
Description=Restart OpenVPN after suspend

[Service]
ExecStart=/usr/bin/pkill --signal SIGHUP --exact openvpn

[Install]
WantedBy=sleep.target
EOD
