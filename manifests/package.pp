class facter::package {

  include facter

  if $facter::provider == 'portage' {
  } else {
    package { $facter::packge_name:
      ensure          => $facter::ensure,
      provider        => $facter::provider,
      install_options => $facter::install_options,
    }
  }

}
