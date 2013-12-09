class java::install {

  package { 'java-1.7.0-openjdk.x86_64':
    ensure => absent,
  }

  case $::osfamily {
    'Darwin' : { # assuming you did download wget - ill maybe fix this and check for it
      exec { 'wget-java-package':
        cwd     => "${java::params::tmpdir}",
        command => "${java::params::cmdwget} --no-check-certificate ${java::params::downloadURL}",
        creates => "${java::params::tmpdir}/${java::params::version}.${java::params::format}",
        timeout => 2400,
      }
    }
    default : {
      exec { 'wget-java-package':
        cwd     => "${java::params::tmpdir}",
        command => "${java::params::cmdwget} --no-check-certificate ${java::params::downloadURL}",
        creates => "${java::params::tmpdir}/${java::params::version}.${java::params::format}",
        timeout => 2400,
      }
    }
  }
  exec { 'mkdirp-java-installdir':
    cwd     => "${java::params::tmpdir}",
    command => "/bin/mkdir -p ${java::params::installdir}",
    creates => "${java::params::installdir}",
  }
  exec { 'untar-java-package':
    cwd     => "${java::params::installdir}",
    command => "/bin/tar -xf ${java::params::tmpdir}/${java::params::version}.${java::params::format}",
    creates => "${java::params::javahome}",
    require => [Exec['wget-java-package'],Exec['mkdirp-java-installdir']],
  }
}