#!/usr/bin/env bash

echo "install powerline font, it's needed for rendering tmux/zsh/vim themes"
curl -Lo .fonts/OTF/source-code-pro-powerline.otf --create-dirs https://raw.githubusercontent.com/powerline/fonts/master/SourceCodePro/Source%20Code%20Pro%20for%20Powerline.otf

echo "Creating a new SSH key"
ssh-keygen -t rsa -b 4096 -a 100
