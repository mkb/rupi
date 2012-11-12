# DON'T RUN THIS!!!!
# very preliminary work.
#
#
# wget -O - -q https://raw.github.com/mkb/rupi/master/setup.sh | sudo sh

echo "I like food."
set +x

echo 'Recreating your ssh keys...'
rm /etc/ssh/ssh_host_* && dpkg-reconfigure openssh-server

echo 'Installing and configuring avahi-daemon...'
apt-get install avahi-daemon
insserv avahi-daemon

cat <<EOT >taco_bell_dog
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


echo 'Done!'

