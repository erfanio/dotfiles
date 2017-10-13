#!/usr/bin/env bash
# save previous zshrc
mv -v ~/.zsh ~/.zsh.orig

# setup oh my zsh
echo "Setup OH MY ZSH"
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
curl -fLo ~/.oh-my-zsh/custom/bullet-train.zsh-theme --create-dirs http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme

# create necessary directories
mkdir -v ~/.vim 2>/dev/null
mkdir -v ~/.config 2>/dev/null
mkdir -v -p ~/.tmux/plugins 2>/dev/null

# add our global .gitignore
git config --global core.excludesfile ~/dotfiles/.gitignore_global
# load tmux package manager
echo "Install TPM"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "To Install TMUX Plugins, Press prefix + I when you first start tmux"
# load vim plug (package manager)
echo "Install VIM PLUG"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "To Install VIM Plugins, Run :PlugInstall when you first start vim"

# symlinks
ln -v -s ~/dotfiles/.zshrc ~/.zshrc
touch ~/.zshrc_custom
ln -v -s ~/dotfiles/.vimrc ~/.vimrc
ln -v -s ~/dotfiles/.vim_runtime ~/.vim_runtime
ln -v -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -v -s ~/dotfiles/i3 ~/.config/i3
ln -v -s ~/dotfiles/.xinitrc ~/.xinitrc
ln -v -s ~/dotfiles/termite ~/.config/termite
