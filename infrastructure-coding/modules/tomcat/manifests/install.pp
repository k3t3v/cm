class tomcat::install {
  package { 'jdk-7u45-linux-x64':
    ensure => present,
  }
  
  exec { 'wget-tomcat-package':
    cwd     => "${tomcat::params::tmpdir}",
    command => "${tomcat::params::cmdwget} --no-check-certificate ${tomcat::params::downloadURL}",
    creates => "${tomcat::params::tmpdir}/${tomcat::params::package}",
    timeout => 2400,
  }

  exec { 'mkdirp-tomcat-installdir':
    cwd     => "${tomcat::params::tmpdir}",
    command => "/bin/mkdir -p ${tomcat::params::installdir}",
    creates => "${tomcat::params::installdir}",
  }

  exec { 'untar-tomcat-package':
    cwd     => "${tomcat::params::installdir}",
    command => "/bin/tar -xf ${tomcat::params::tmpdir}/${tomcat::params::package}",
    creates => "${tomcat::params::tomcat_homedir}",
    require => [Exec['wget-tomcat-package'], Exec['mkdirp-tomcat-installdir']],
  }
}