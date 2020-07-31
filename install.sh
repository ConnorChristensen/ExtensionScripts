#!/bin/bash

# install homebrew
if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# install all packages in the Brewfile
brew bundle

# zsh configuration
mkdir ~/.zsh/
touch ~/.zshrc
ln -s ${PWD}/zshrc ~/.zsh/default_zshrc
echo "Please read the README to make full use of the zsh configuration"
echo 'if [ -f ~/.zsh/default_zshrc ]; then' >> ~/.zshrc
echo 'source ~/.zsh/default_zshrc' >> ~/.zshrc
echo 'else' >> ~/.zshrc
echo 'print "404: ~/.zsh/default_zshrc not found." fi' >> ~/.zshrc
echo "export PATH='\$PATH:${PWD}/scripts'" >> ~/.zshrc
