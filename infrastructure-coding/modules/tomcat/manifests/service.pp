class tomcat::service {
  service {"tomcat":
    provider    => base,
    start       => "/etc/init.d/start_tomcat.sh",
    restart     => "",
    stop        => "/etc/init.d/stop_tomcat.sh",
    status      => "",
    enable      => true,
    ensure      => "running",
    hasrestart  => false,
    require     => [Exec["untar-tomcat-package"], File["/etc/init.d/start_tomcat.sh"], File["/etc/init.d/stop_tomcat.sh"]],
  }
}