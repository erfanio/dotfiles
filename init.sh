#!/usr/bin/env bash
# add our global .gitignore
git config --global core.excludesfile ~/dotfiles/.gitignore_global
# load tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# load vim plug (package manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
