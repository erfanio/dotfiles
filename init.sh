#!/usr/bin/env bash
# save previous zshrc
mv -v ~/.zsh ~/.zsh.orig

# setup oh my zsh
echo "Setup OH MY ZSH"
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
curl -fLo ~/.oh-my-zsh/custom/bullet-train.zsh-theme --create-dirs http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
# font is needed for rendering tmux/zsh/vim themes
curl -Lo .fonts/OTF/source-code-pro-powerline.otf --create-dirs https://raw.githubusercontent.com/powerline/fonts/master/SourceCodePro/Source%20Code%20Pro%20for%20Powerline.otf

# setting up git
git config --global user.email "dev@erfan.io"
git config --global user.name "erfanio"

# create necessary directories
mkdir -v ~/.config 2>/dev/null
mkdir -v -p ~/.tmux/plugins 2>/dev/null
mkdir -v -p ~/dotfiles/.vim/temp/undodir 2>/dev/null

# load tmux package manager
echo "Installing TPM"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "To Install TMUX Plugins, Press prefix + I when you first start tmux"
# load vim plug (package manager)
echo "Installing VIM PLUG"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "To Install VIM Plugins, Run :PlugInstall when you first start vim"

# symlinks
ln -v -s ~/dotfiles/.zshrc ~/.zshrc
touch ~/.zshrc_custom
ln -v -s ~/dotfiles/.vim ~/.vim
ln -v -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -v -s ~/dotfiles/termite ~/.config/termite
