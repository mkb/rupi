#!/bin/bash

############
# WARNING: This file is generated by a rake task. Do not edit it directly.
############


emit () {
  set +x
  echo -en '\e[41;37m'"RuPi:\033[0m"
  echo -e "\033[1m $1\033[0m"
  set -x
}
#######
# 00_start.sh

# DON'T RUN THIS!!!!
# very preliminary work.  it will break your shit.
#
#
# curl https://raw.github.com/mkb/rupi/master/setup.sh | sudo bash

set -e
emit "Started."


#######
# 10_update_ports.sh

emit 'Updating your ports...'
set -x
apt-get update -y
apt-get upgrade -y


#######
# 20_avahi.sh

install_avahi_daemon() {
  emit 'Checking for avahi-daemon...'
  dpkg -L avahi-daemonsd > /dev/null 2>&1 || echo 'Found. Skipping setup.' && return

  local avahi_config='/etc/avahi/services/multiple.service'
  [ -f $avahi_config ] && echo "$avahi_config already exists. Skipping avahi setup." && return

  apt-get install -y avahi-daemon
  insserv avahi-daemon

  cat <<EOT > $avahi_config
  <?xml version="1.0" standalone='no'?>
  <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
  <service-group>
    <name replace-wildcards="yes">%h</name>
    <service>
      <type>_device-info._tcp</type>
      <port>0</port>
      <txt-record>model=RackMac</txt-record>
    </service>
    <service>
      <type>_ssh._tcp</type>
      <port>22</port>
    </service>
  </service-group>
EOT

  /etc/init.d/avahi-daemon restart
}

install_avahi_daemon


#######
# 30_prerequisites.sh

emit "Installing Ruby prerequisites..."
apt-get install -y git curl zlib1g-dev subversion
apt-get install -y openssl libreadline6-dev git-core zlib1g libssl-dev
apt-get install -y libyaml-dev libsqlite3-dev sqlite3
apt-get install -y libxml2-dev libxslt-dev
apt-get install -y autoconf automake libtool bison

# build-essential libc6-dev ncurses-dev pkg-config


#######
# 40_rvm.sh

emit "Installing Ruby Version Manager (rvm)..."
su - pi -c 'curl -L get.rvm.io | bash -s stable --without-gems="rvm rubygems-bundler"'
. ~pi/.rvm/scripts/rvm


#######
# 50_ruby.sh

emit "Installing Ruby 1.9.3"
su - pi -c 'command rvm install 1.9.3 ; rvm use --default 1.9.3'



#######
# 60_rails.sh

emit "Installing Rails"
su - pi -c 'gem install rails'


#######
# 70_nodejs.sh

emit "Installing Node.js..."
sudo apt-get install -y nodejs npm


#######
# 99_done.sh

# TODO
# ----
# validate that we are running as pi user
# start with warning banner and/or question
# check for existing avahi install or config
# install node for its JS runtime
# split into subscripts

# if [ -f ~pi/.bashrc ]; then
#   cat >> ~pi/.bashrc
# fi
# source ~/.rvm/scripts/rvm
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# OS config bits.  TZ, etc.
# set hostname (rm -f ~/.zcompdump)
# user account
# set pw
# grow partition

# output a pointer to learn more somewhere...

emit 'Done!'


