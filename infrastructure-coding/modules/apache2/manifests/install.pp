class apache2::install {
  package { 'httpd':
    name   => "httpd.x86_64",
    ensure => installed,
  }
}