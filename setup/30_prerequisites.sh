#!/bin/bash

emit "Installing Ruby prerequisites..."
apt-get install -y git curl zlib1g-dev subversion
apt-get install -y openssl libreadline6-dev git-core zlib1g libssl-dev
apt-get install -y libyaml-dev libsqlite3-dev sqlite3
apt-get install -y libxml2-dev libxslt-dev
apt-get install -y autoconf automake libtool bison

# build-essential libc6-dev ncurses-dev pkg-config
