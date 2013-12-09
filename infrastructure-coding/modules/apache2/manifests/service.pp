class apache2::service {
  service { 'httpd-service':
		ensure => "running",
		enable => true,
		require => Package['httpd'],
  }
}