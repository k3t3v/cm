class tomcat {
  # require java
  include tomcat::params
  include tomcat::install
  include tomcat::config
  include tomcat::service
}