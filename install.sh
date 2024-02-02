#!/bin/bash
#
# install script for migrating/updating stuff

install () {
echo "Installing or Updating dotfiles"

local date=$(date -jI)

echo "date: $date"

local files=(foo.zsh bar.zsh baz.zsh)

local files_backed_up=0

local prefix=~/tmp

local full_path=$(pwd)
echo "$full_path"

for file in ${files[@]}; do
  echo "$file"
  if [[ -f $prefix/$file ]]; then
    echo "file exists...is it a symlink?"
    if [[ -L $prefix/$file ]]; then
      echo "it is a symlink!"
    else
      echo "nope!"
      echo "new name: $prefix/$file.old-$date"
      mv "$prefix/$file" "$prefix/$file.old-$date"
      ((files_backed_up+=1))
    fi
  else
    echo "file doesn't exist"
  fi
  ln -s "$full_path/$file" "$prefix/$file"
done

printf "number of files backed up: %d\n" $files_backed_up
}
install
