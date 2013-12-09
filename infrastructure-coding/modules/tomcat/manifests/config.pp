class tomcat::config {
  file { '/etc/init.d/start_tomcat.sh':
    ensure  => present,
    mode    => '0755',
    content => template('tomcat/etc/init.d/start_tomcat.sh.erb')
  }
  
  file { '/etc/init.d/stop_tomcat.sh':
    ensure  => present,
    mode    => '0755',
    content => template('tomcat/etc/init.d/stop_tomcat.sh.erb')
  }
}