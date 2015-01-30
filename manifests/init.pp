class facter (
  $packge_name     = $facter::params::package_name,
  $ensure          = 'present',
  $provider        = $facter::params::provider,
  $install_options = $facter::params::install_options,
) inherits facter::params {

  include facter::package

  file { '/etc/facter': ensure => 'directory' }
  ->
  file { '/etc/facter/facts.d': ensure  => 'directory' }

}
