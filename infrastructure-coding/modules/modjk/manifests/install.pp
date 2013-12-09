class modjk::install {
  package { 'apache2-mod_jk-1.2.37-4.1.x86_64.rpm':
    ensure => absent,
  }
  
  exec { 'wget-modjk-package':
    cwd     => "${modjk::params::tmpdir}",
    command => "${modjk::params::cmdwget} --no-check-certificate ${modjk::params::downloadUrl}",
    creates => "${modjk::params::tmpdir}/${modjk::params::package}",
  }
  
  exec { 'install-modjk-package':
    command => "/usr/bin/yum install -y ${modjk::params::tmpdir}/${modjk::params::package}",
    require => Exec['wget-modjk-package'],
  }
}