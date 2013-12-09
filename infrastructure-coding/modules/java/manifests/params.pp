class java::params {
  $javahome    = hiera('common_java_homedir')
  $installdir  = hiera('common_java_installdir')
  $tmpdir      = hiera('common_tmpdir')
  $version     = hiera('common_java_version')
  $format      = hiera('common_java_package_format')
  $downloadURL = hiera('common_java_downloadurl')
  $cmdwget     = hiera('common_cmdwget')
}