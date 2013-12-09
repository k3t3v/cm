class deployWar::install {
  exec { 'deploy-package':
    cwd     => "${deployWar::params::webappDir}",
    command => "${deployWar::params::cmdwget} --no-check-certificate ${deployWar::params::package}",
    creates => "${deployWar::params::webappDir}/${deployWar::params::package}",
  }
}