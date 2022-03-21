#!/bin/bash

# install homebrew if not already installed
if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# install all packages in the Brewfile
brew bundle

brew install --cask visual-studio-code
brew install --cask insomnia
brew install --cask monitorcontrol

######### Other applications you may want ########
# brew install --cask slack
# Little app for managing homebrew utils
# brew install --cask cakebrew
# Little app for uninstalling applications that are not installed through
# a package manager
# brew install --cask appcleaner

####### zsh configuration ######
# create a zsh folder
mkdir ~/.zsh/
# create a zshrc file if it does not already exist
touch ~/.zshrc
# create a symbolic file that forwards to the zshrc file in this project
ln -s ${PWD}/zshrc ~/.zsh/default_zshrc

# tell the user to read the readme
echo "Please read the README to make full use of the zsh configuration"

# code that will load in the default zshrc file or print an error if the
# file can not be located
echo 'if [ -f ~/.zsh/default_zshrc ]; then' >> ~/.zshrc
echo 'source ~/.zsh/default_zshrc' >> ~/.zshrc
echo 'else' >> ~/.zshrc
echo 'print "404: ~/.zsh/default_zshrc not found." fi' >> ~/.zshrc
echo "export PATH='\$PATH:${PWD}/scripts'" >> ~/.zshrc

# put the alert sound in the home directory so it can be used anywhere
cp alert.wav ~/.alert.wav
