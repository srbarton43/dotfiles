#!/bin/bash
#
# install script for migrating/updating stuff

install () {
echo "Installing or Updating dotfiles"

full_path="$(dirname -- "${BASH_SOURCE[0]}")"            # relative
full_path="$(cd -- "$full_path" && pwd)"    # absolutized and normalized

echo "$full_path"

# for renaming old files
local date=$(date -I)

# dotfiles or directories that are tracked
local files=(.gitconfig .viminfo .vimrc .vim .zshrc .zsh)

# config files or directories
local config_files=(starship.toml fish nvim)

# add .config prefix to the path
local with_prefix=("${config_files[@]/#/.config/}")

# to keep track of files renamed (backed up)
local files_backed_up=0

# should be the home directory, ~
local dest_prefix=~

echo "$dest_prefix"

# loop through non .config dotfiles
for file in ${files[@]}; do
  echo "$file"
  echo "$dest_prefix/$file"
  if [[ -e $dest_prefix/$file ]]; then
    echo "file exists...is it a symlink?"
    if [[ -L $dest_prefix/$file ]]; then
      echo "it is a symlink!"
    else
      echo "nope!"
      echo "new name: $dest_prefix/$file.old-$date"
      mv "$dest_prefix/$file" "$dest_prefix/$file.old-$date"
      ((files_backed_up+=1))
    fi
  else
    echo "file doesn't exist"
  fi
  echo "linking file"
  ln -sf "$full_path/$file" "$dest_prefix"
done

echo "time for config directory"

# create .config file just in case
mkdir -p "$dest_prefix/.config"

# loop through .config files
for file in "${with_prefix[@]}"; do
  echo "$file"
  echo "$dest_prefix/$file"
  if [[ -e $dest_prefix/$file ]]; then
  echo "file exists...is it a symlink?"
    if [[ -L $dest_prefix/$file ]]; then
      echo "it is a symlink!"
    else
      echo "nope!"
      echo "new name: $dest_prefix/$file.old-$date"
      mv "$dest_prefix/$file" "$dest_prefix/$file.old-$date"
      ((files_backed_up+=1))
    fi
  else
    echo "file doesn't exist"
  fi
  echo "linking file"
  ln -sf "$full_path/$file" "$dest_prefix/.config"
done

printf "number of files backed up: %d\n" $files_backed_up
}

install
