#!/bin/bash

# DON'T RUN THIS!!!!
# very preliminary work.  it will break your shit.
#
#
# wget -O - -q https://raw.github.com/mkb/rupi/master/setup.sh | sudo bash

set -e

emit () {
  set +x
  echo -en '\e[41;37m'"RuPi:\033[0m"
  echo -e "\033[1m $1\033[0m"
  set -x
}

emit "Started."

#################
emit 'Checking your ssh host keys...'
set +x
fingerprint=$(ssh-keygen -l -f /etc/ssh/ssh_host_dsa_key.pub)
if [[ $fingerprint =~ 1:2:3:4:5 ]]
then
  emit 'Looks like you have the default keys which is not good.'
  set +x
  read -p "Do you want to recreate your ssh host keys? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sleep 2
    echo -n -e "\007\007"
    read -p "Are you sure? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      set -x
      rm /etc/ssh/ssh_host_* && dpkg-reconfigure openssh-server
    fi
  fi
fi

#############
emit 'Updating your ports...'
set -x
apt-get update -y
apt-get upgrade -y

############
emit 'Installing and configuring avahi-daemon...'
apt-get install -y avahi-daemon
insserv avahi-daemon

cat <<EOT >/etc/avahi/services/multiple.service
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

#############
emit "Installing Ruby prerequisites..."
apt-get install -y git curl zlib1g-dev subversion
apt-get install -y openssl libreadline6-dev git-core zlib1g libssl-dev
apt-get install -y libyaml-dev libsqlite3-dev sqlite3
apt-get install -y libxml2-dev libxslt-dev
apt-get install -y autoconf automake libtool bison

# build-essential libc6-dev ncurses-dev pkg-config

################
emit "Installing Ruby Version Manager (rvm)..."
su - pi -c 'curl -L get.rvm.io | bash -s stable --rails --without-gems="rvm rubygems-bundler"'

# if [ -f ~pi/.bashrc ]; then
#   cat >> ~pi/.bashrc
# fi
# source ~/.rvm/scripts/rvm
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# --auto?
# --rails?

################
emit "Installing Ruby 1.9.3"
su - pi -c 'command rvm install 1.9.3 ; rvm use --default 1.9.3'

# which JS runtime?

# OS config bits.  TZ, etc.
# simplify invocation

# set hostname (rm -f ~/.zcompdump)
# user account
# set pw
# grow partition

# output a pointer to learn more somewhere...

emit 'Done!'

