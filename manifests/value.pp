# == Define: sysctl::value
#
# sysctl/manifests/init.pp - Define sysctl module stuff
#
# == Parameters
#
# [*value*]
#  Value to set in sysctl.conf.  Set vaule to 'nil' to remove the
#  variable from the sysctl.conf file.
#
# == Author
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define sysctl::value(
  $value
){
  include 'sysctl'

  sysctl { $name:
    ensure  => $value ? {
      'nil'   => 'absent',
      default => 'present'
    },
    val     => $value,
    require => File['/etc/sysctl.conf']
  }

  if "$value" != 'nil' {
    sysctl_set_value { $name:
      val => $value
    }
  }

  validate_string($value)
}
