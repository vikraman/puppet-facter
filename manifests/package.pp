class facter::package {

  include facter

  if $facter::package_name {
    $package_name = $facter::package_name
  } else {
    if $facter::provider == 'gem' {
      $package_name = 'facter'
      include facter::package::gem
    } else {
      if $::operatingsystem == 'OpenSuSE' and $::operatingsystemrelease > '13.2' {
        $package_name = 'ruby2.1-rubygem-facter'
        package { 'rubygem-facter':
          ensure          => $facter::ensure,
          install_options => $facter::install_options,
        }
      } elsif $::operatingsystem == 'Gentoo' {
        $package_name = 'dev-ruby/facter'
      } else {
        $package_name = 'facter'
      }
    }
  }

  if $facter::provider == 'portage' {
    include facter::package::portage
  }

  package { $package_name:
    ensure          => $facter::ensure,
    provider        => $facter::provider,
    install_options => $facter::install_options,
  }
}
