class facter (
  $packge_name     = $facter::params::package_name,
  $ensure          = 'present',
  $provider        = undef,
  $install_options = undef,
) inherits facter::params {

  include facter::package

  file { '/etc/facter': ensure => 'directory' }
  ->
  file { '/etc/facter/facts.d': ensure  => 'directory' }

}
