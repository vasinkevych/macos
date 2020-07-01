#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"




# xcode-select —-install

# Check for Homebrew, install if we don't have it
# if test ! $(which brew); then
#     echo "Installing homebrew..."
# fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Update homebrew recipes
brew update

# Install Bash 4
brew install bash

echo "Installing packages..."

brew install    git
brew install    node
brew install    postgresql
brew install    python
brew install    python3
brew install    pypy
brew install    wget
brew install    yarn

# docker
brew install    bash-completion
brew install    docker-completion
brew install    docker-compose-completion
brew install    docker-machine-completion

brew tap mongodb/brew
brew install mongodb-community


echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask


brew cask install    firefox
brew cask install    google-drive
brew cask install    iterm2
brew cask install    skype
brew cask install    slack
brew cask install    virtualbox
brew cask install    vlc
brew cask install    adoptopenjdk8
brew cask install    postman
brew cask install    robo-3t
brew cask install    docker
brew tap adoptopenjdk/openjdk
brew cask install    adoptopenjdk8


echo "Installing cask apps..."

# echo "Installing fonts..."
# brew tap caskroom/fonts
# FONTS=(
brew cask install    font-inconsolidata
brew cask install     font-roboto
brew cask install     font-clear-sans
# )
# brew cask install ${FONTS[@]}

echo "Installing Python packages..."

sudo pip install ipython
sudo pip install virtualenv
sudo pip install virtualenvwrapper

sh -c "$(curl -fsSL https://raw.githubus  ercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# echo "Installing Ruby gems"
# RUBY_GEMS=(
#     bundler
#     filewatcher
#     cocoapods
# )
# sudo gem install ${RUBY_GEMS[@]}

echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

echo "Configuring OSX..."

# Show filename extensions by default
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.finder AppleShowAllFiles YES


echo "Creating folder structure..."
[[ ! -d github ]] && mkdir github
[[ ! -d clients ]] && mkdir clients

echo "Bootstrapping complete"
