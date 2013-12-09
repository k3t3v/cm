class deployWar::params {
  $webappDir  = hiera('deploy_webappDir')
  $package    = hiera('deploy_package')
  
  $cmdwget    = hiera('common_cmdwget')
  
}