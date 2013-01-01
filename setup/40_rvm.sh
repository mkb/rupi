#!/bin/bash

emit "Installing Ruby Version Manager (rvm)..."
su - pi -c 'curl -L get.rvm.io | bash -s stable --without-gems="rvm rubygems-bundler"'
. ~pi/.rvm/scripts/rvm
