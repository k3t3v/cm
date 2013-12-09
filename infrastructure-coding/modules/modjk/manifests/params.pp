class modjk::params {
  $package              = hiera('mod_jk_package')
  $downloadUrl          = hiera('mod_jk_downloadUrl')
  
  #execution environment
  $optdir               = hiera('common_optdir')
  $java_homedir         = hiera('common_java_homedir')
  $tmpdir               = hiera('common_tmpdir')
  $cmdwget              = hiera('common_cmdwget')
}