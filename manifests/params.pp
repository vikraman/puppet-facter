class facter::params {
  case $::operatingsystem {
    'Gentoo': { $package_name = 'dev-ruby/facter' }
    'OpenSuSE': {
      if $::operatingsystemrelease > '13.2' {
        $package_name = 'ruby2.1-rubygem-facter'
      }
    }
    default: { $package_name = 'facter' }
  }
}
