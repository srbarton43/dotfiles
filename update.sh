#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Updating dotfiles in home directory from $SCRIPT_DIR"

for FILE in gitconfig tmux.conf viminfo vimrc zshrc config vim zsh
do
	ln -shF ${SCRIPT_DIR}/${FILE} ~/.${FILE}
done
