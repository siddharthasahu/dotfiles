#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
[[ -z "$DIR" ]] && echo "Could not find script directory" && exit -1

link_file() {
    [[ -z "$1" ]] && return -1
    echo "Setting up $1"
    [[ -r ~/"$1" ]] && echo "File contents of $1" && cat ~/"$1" && echo
    rm -f ~/"$1" && ln -s "$DIR/$1" ~
}

echo "Setting up .bashrc"
[[ -r ~/.bashrc ]] && echo "File contents of .bashrc" && cat ~/.bashrc && echo
echo -e ". $DIR/.bashrc" > ~/.bashrc

echo "Setting up .zshrc"
[[ -r ~/.zshrc ]] && echo "File contents of .zshrc" && cat ~/.zshrc && echo
echo -e ". $DIR/.bashrc\n. $DIR/.zshrc" > ~/.zshrc

link_file ".tmux.conf"
link_file ".gitconfig"
link_file ".vimrc"