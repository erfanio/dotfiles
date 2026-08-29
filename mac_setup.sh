#!/usr/bin/env bash

echo "Link Aerospace config"
ln -v -s ~/dotfiles/.aerospace.toml ~/.aerospace.toml
ln -v -s ~/dotfiles/agents ~/.agents

echo "Link Alacritty config"
mkdir ~/.config/
ln -v -s ~/dotfiles/alacritty ~/.config/alacritty
ln -v -s ~/dotfiles/karabiner ~/.config/karabiner

echo "Adjust keyboard repeat behaviour"
defaults write -g InitialKeyRepeat -float 15.0
defaults write -g KeyRepeat -float 2.0

echo "Install brew then run the following"
echo "$ brew install ripgrep coreutils findutils gnu-tar gnu-sed gawk aerospace neovim tmux maccy stats karabiner-elements htop font-sauce-code-pro-nerd-font scroll-reverser"
