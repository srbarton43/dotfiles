#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Updating dotfiles in home directory from $SCRIPT_DIR"
ln -sf $SCRIPT_DIR/.gitconfig ~
ln -sf $SCRIPT_DIR/.tmux.conf ~
ln -sf $SCRIPT_DIR/.viminfo ~
ln -sf $SCRIPT_DIR/.vimrc ~
ln -sf $SCRIPT_DIR/.zshrc ~
ln -sf $SCRIPT_DIR/.config/ ~
ln -sf $SCRIPT_DIR/.vim/ ~
