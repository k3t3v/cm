class apache2 {
  include apache2::params
  include apache2::install
  include apache2::service
}