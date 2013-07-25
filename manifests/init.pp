# == Class: java
#
#
class java (
  $version = "1.7.0.21",
  $source = "puppet:///files/distfiles/jre-7u21-linux-x64.tar.gz",
) {
  $distfile = "";
  case $version {
    '1.7.0.21': {
      $distfile = "jre-7u21-linux-x64.tar.gz",
    }
    '1.7.0.25': {
      $distfile = "jre-7u25-linux-x64.tar.gz",
    }
    default: {
      fail("unsupported version ${version}")
    }
  }

  # Module compatibility check
  $compatible = [ 'Gentoo' ]
  if ! ($::operatingsystem in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  file { "/usr/portage/distfiles/${distfile}":
    source => $source
  } ->
  portage::package { 'dev-java/oracle-jre-bin':
    ensure           => $version,
    keywords         => ['~amd64'],
  }
}
