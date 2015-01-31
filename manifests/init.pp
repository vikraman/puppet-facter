class facter (
  $packge_name     = undef,
  $ensure          = 'present',
  $provider        = undef,
  $install_options = undef,
) {

  include facter::package

  file { '/etc/facter': ensure => 'directory' }
  ->
  file { '/etc/facter/facts.d': ensure  => 'directory' }

}
