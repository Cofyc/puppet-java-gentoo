# == Class: java
#
#
class java (
  $version = "1.7.0.21",
  $source = "puppet:///files/distfiles/jre-7u21-linux-x64.tar.gz",
) {
  case $version {
    '1.7.0.21': {
      file { "/usr/portage/distfiles/jre-7u21-linux-x64.tar.gz":
        source => $source
      }
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

  portage::package { 'dev-java/oracle-jre-bin':
    ensure           => $version,
    keywords         => ['~amd64'],
  }
}
