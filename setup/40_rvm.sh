#!/bin/bash

emit "Installing Ruby Version Manager (rvm)..."
su - pi -c 'curl -L get.rvm.io | bash -s stable --without-gems="rvm rubygems-bundler"'
. ~pi/.rvm/scripts/rvm
echo "\n\n" >> .bashrc
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> .bashrc
echo "\n\n" >> .bashrc
