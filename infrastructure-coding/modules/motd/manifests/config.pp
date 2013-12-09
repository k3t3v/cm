#--------------------------------------------------------------------------------------------------------------
# == Class: motd::config
#
# Config file for motd class
#
# === Authors
#
# Muhammad Pavel
#---------------------------------------------------------------------------------------------------------------

class motd::config {
  file { '/etc/motd':
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    content  => template('motd/etc/motd.erb'),
  }
}