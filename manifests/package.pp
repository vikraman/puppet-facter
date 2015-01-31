class facter::package {

  include facter

  $package_name = $facter::provider ? {
    'gem'   => 'facter',
    default => $facter::package_name,
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
