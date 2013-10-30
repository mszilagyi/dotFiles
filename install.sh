#!/bin/bash

# Determine environment
if [ `uname -s` == "Linux" ]; then
    if grep -q "Ubuntu" /etc/issue; then
        ENVSETUPENV="Ubuntu"
        # go ahead and install a vim with everything compiled in
        sudo apt-get -y install vim-gnome exuberant-ctags ack-grep python-setuptools python-dev ipython
    fi
elif [ `uname -s` == "Darwin" ]; then
    brew install ctags ack
else
    echo Unknown environment.
    exit
fi

# Install python dependencies
sudo pip install pep8 pyflakes

# Initialize and pull git submodules
rm -rf `pwd`/vim/vim/bundle/*

git clone https://github.com/scrooloose/nerdtree.git vim/vim/bundle/nerdtree
git clone https://github.com/vim-scripts/pep8.git vim/vim/bundle/pep8
git clone https://github.com/davidhalter/jedi-vim vim/vim/bundle/jedi-vim --recurse-submodules

rm -rf $HOME/.vim $HOME/.vimrc $HOME/.gvimrc
rm -rf $HOME/.screenrc
rm -rf $HOME/.bash_profile

ln -s `pwd`/vim/vim $HOME/.vim
ln -s `pwd`/vim/vimrc $HOME/.vimrc
ln -s `pwd`/vim/gvimrc $HOME/.gvimrc
ln -s `pwd`/screenrc $HOME/.screenrc
ln -s `pwd`/bash_profile $HOME/.bash_profile

# Set up git aliases.
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
