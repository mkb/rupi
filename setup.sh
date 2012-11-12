#!/bin/bash

# DON'T RUN THIS!!!!
# very preliminary work.
#
#
# wget -O - -q https://raw.github.com/mkb/rupi/master/setup.sh | sudo bash

emit () {
  echo -en '\e[41;34m'"RuPi:\033[0m"
  echo -e "\033[1m $1\033[0m"
}

emit "Started."
set -x

#################
emit 'Recreating your ssh keys...'
rm /etc/ssh/ssh_host_* && dpkg-reconfigure openssh-server


############
emit 'Installing and configuring avahi-daemon...'
apt-get install avahi-daemon
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

emit "Installing Ruby prerequisites"
apt-get install -y git curl zlib1g-dev subversion
apt-get install -y openssl libreadline6-dev git-core zlib1g libssl-dev
apt-get install -y libyaml-dev libsqlite3-dev sqlite3
apt-get install -y libxml2-dev libxslt-dev
apt-get install -y autoconf automake libtool bison

# build-essentials?

# subscript as unpriv user?
#curl -L get.rvm.io | bash -s stable --without-gems="rvm rubygems-bundler
# --auto?
# source ~/.rvm/scripts/rvm
#rvm install 1.9.3
#rvm use --default 1.9.3
# JS runtime?

# OS config bits.  TZ, etc.
# update packages
# simplify invocation

# set hostname
# user account
# set pw
# grow partition


emit 'Done!'

