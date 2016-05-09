#!/bin/sh

# Huge thanks to Matthew Mueller and his blogpost at http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew.."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update

echo "Installing packages.."

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4 (Hello Shellshock)
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install other useful binaries
binaries=(
  ack
  autojump
  git
  glide
  go
  hub
  hugo
  maven
  node
  nvm
  pt
  python
  rbenv
  ruby-build
  sshfs
  the_platinum_searcher
  tree
)

# Install the binaries
brew install ${binaries[@]}

# Install Cask
brew install caskroom/cask/brew-cask

# Remove outdated versions from the cellar
brew cleanup

apps=(
  1password
  alfred
  bitbar
  dash
  disk-inventory-x
  dockertoolbox
  dropbox
  evernote
  firefox
  flux
  google-chrome
  heroku-toolbelt
  intellij-idea
  istat-menus
  iterm2
  java
  polymail
  qlcolorcode
  qlmarkdown
  qlstephen
  quicklook-json
  slack
  spotify
  sublime-text3
  telegram
  virtualbox
  vlc
)

# Adding beta versions
brew tap caskroom/versions

echo "Installing apps.."
brew cask install ${apps[@]}

echo "Setting up zsh"
curl -L http://install.ohmyz.sh | sh

#TODO: Dotfiles
mkdir ~/code
git clone git@github.com:haraldringvold/zsh-dotfiles.git ~/code/zsh-dotfiles

echo export PATH='/usr/local/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH' >> ~/.zshrc # <- TODO: Make idempotent

echo "Settings.."
defaults write com.apple.finder AppleShowAllFiles YES

echo "\nDone!"
echo "Remember to install Pixelmator, Swipes and Wunderlist from AppStore"

exit 0

