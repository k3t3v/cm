class tomcat::params {
  # Tomcat user details
  # $user_home            = hiera('tomcat_user_home')
  # $user_password        = hiera('tomcat_user_password')
  # $user                 = hiera('tomcat_user')
  # $group                = hiera('tomcat_group')
  # $gid                  = hiera('tomcat_gid')
  # $uid                  = hiera('tomcat_uid')
  
  #Tomcat package details
  $downloadURL          = hiera('tomcat_download_url')
  $package              = hiera('tomcat_package')
  $installdir           = hiera('tomcat_installdir')
  $tomcat_homedir       = hiera('tomcat_homedir')
  
  #execution environment
  $optdir               = hiera('common_optdir')
  $java_homedir         = hiera('common_java_homedir')
  $tmpdir               = hiera('common_tmpdir')
  $cmdwget              = hiera('common_cmdwget')
  
}