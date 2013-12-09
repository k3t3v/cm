node 'devops.vagrant.test' {
  $shared_folder = '/vagrant-share'

  group { 'puppet':
        ensure => 'present',
  }

  include motd
  include repos
  include zip
  include java
  include apache2
  include modjk
  include tomcat
  include deployWar
}
