class repos {
  case $::osfamily {
    'RedHat' : {
      yumrepo { 'nginx':
        descr    => 'Nginx Repo',
        baseurl  => 'http://nginx.org/packages/rhel/6/x86_64/',
        enabled  => 1,
        gpgcheck => 0,
      }
      # put a case statement here
      yumrepo { 'epel6_x86_64':
        descr    => 'EPEL 6 - x86_64',
        baseurl  => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/',
        enabled  => 1,
        gpgcheck => 0,
      }
    }
    default : {
      notify {"OS Family $::osfamily not supported in class repos":}
    }
  }
}