#!/bin/bash

emit "Installing Ruby 1.9.3"
su - pi -c 'command rvm install 1.9.3 ; rvm use --default 1.9.3'

