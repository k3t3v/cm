class modjk::config {
  file { '/etc/httpd/conf/httpd.conf':
    ensure  => present,
    mode    => '0755',
    content => template('modjk/etc/httpd/conf/httpd.conf.erb')
  }
  
  file { '/etc/httpd/conf/workers.properties':
    ensure  => present,
    mode    => '0755',
    content => template('modjk/etc/httpd/conf/workers.properties.erb')
  }
  
  file { '/etc/httpd/conf.d/tomcat.conf':
    ensure  => present,
    mode    => '0755',
    content => template('modjk/etc/httpd/conf.d/tomcat.conf.erb')
  }
}