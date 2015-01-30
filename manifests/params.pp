class facter::params {

  $install_options = undef

  case $::osfamily {
    'debian': {}
    'gentoo': {
      $package_name  = 'dev-ruby/facter'
      $provider      = 'portage'
    }
    'redhat': {}
    'suse': {
      $pkgname  = 'facter'
      $provider = 'zypper'
    }
    default: { fail("$::osfamily is not supported") }
  }

}
