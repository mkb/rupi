#!/bin/bash

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

