#!/usr/bin/env bash

echo "Link Aerospace config"
ln -v -s ~/dotfiles/.aerospace.toml ~/.aerospace.toml

echo "Adjust keyboard repeat behaviour"
defaults write -g InitialKeyRepeat -float 15.0
defaults write -g KeyRepeat -float 2.0
