#!/bin/bash

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
