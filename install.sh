#!/bin/bash

####### zsh configuration ######
echo ">> Setting up command line interface"
# create a zsh folder
mkdir ~/.zsh/

# create a zsh file that contains user specific configurations
touch ~/.zsh/user

# create a zshrc file if it does not already exist
touch ~/.zshrc

# create a symbolic file that forwards to the zshrc file in this project. -i
# will halt the operation if the file exists at the destination
echo ">> The script may ask you if you want to replace files. If you are unsure, respond with 'n' for 'no' and press enter"
ln -si ${PWD}/command_line/zsh/default_zshrc ~/.zsh/default

# add a some code into the zshrc file that will load in the default zsh config
# file, along with the user specific file. Do not add this if the load_file
# function is already defined in the .zshrc file
if ! grep "load_file" ~/.zshrc &>/dev/null; then
  cat command_line/zsh/append_zshrc.sh >> ~/.zshrc
fi

# reload the zsh file
source ~/.zshrc

# install homebrew if not already installed
echo ">> Checking if homebrew is installed"
if ! command -v brew &> /dev/null
then
  echo ">> Homebrew not found"
  echo ">> Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# install all packages in the Brewfile
echo ">> Installing homebrew utilites"
brew bundle

installed_packages=$(brew list)

# install these packages if they are not already installed
cask_install() {
  # if package not installed
  if ! [[ "$installed_packages" =~ "$1" ]]; then
    brew install --cask $1
  fi
}

echo ">> Installing applications via homebrew"
cask_install visual-studio-code
cask_install monitorcontrol
cask_install hammerspoon
cask_install ubersicht
cask_install firefox
cask_install google-chrome
cask_install microsoft-edge

######### Other applications you may want ########
# brew install --cask slack
# Little app for managing homebrew utils
# brew install --cask cakebrew
# Little app for uninstalling applications that are not installed through
# a package manager
# brew install --cask appcleaner

# create ubersicht widget folder incase ubersicht does not set it up in time
mkdir ${HOME}/Library/Application\ Support/Übersicht/widgets
# move ubersicht widget to the widgets folder
cp ./UI/ubersicht/clock.coffee ${HOME}/Library/Application\ Support/Übersicht/widgets

# add symlinks to the scripts to /usr/local/bin so they are accessible at the sytem level
ln -si ${PWD}/command_line/scripts/git-backup-then-rebase-squash.sh /usr/local/bin/gbrs
ln -si ${PWD}/command_line/scripts/git-backup.sh /usr/local/bin/gb
ln -si ${PWD}/UI/dark-light/ui.sh /usr/local/bin/ui

# create hammerpsoon folder if it does not already exist
mkdir ~/.hammerpsoon
# copy hammerspoon config file into hammerspoon folder since symbolic links do not work
cp ${PWD}/window_manager/init.lua ${HOME}/.hammerspoon/

# put the alert sound in the home directory so it can be used anywhere
cp alert.wav ~/.alert.wav

echo ">> zsh configuration added"
echo ">> Installation finished"
