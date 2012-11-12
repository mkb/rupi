# DON'T RUN THIS!!!!
# very preliminary work.
#
#
# wget -O - -q https://raw.github.com/mkb/rupi/master/setup.sh | sudo bash

emit () {
  echo -en '\e[41;34m'"RuPi:\033[0m"
  echo -e "\033[1m $1\033[0m"
}

emit "I like food."
set +x

emit 'Recreating your ssh keys...'
rm /etc/ssh/ssh_host_* && dpkg-reconfigure openssh-server

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


# OS config bits.  TZ, etc.
# update packages

# set hostname
# user account


emit 'Done!'

