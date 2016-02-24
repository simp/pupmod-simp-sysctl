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

  validate_string($value)

  $_ensure  = $value ? {
    'nil'   => 'absent',
    default => 'present'
  }

  sysctl { $name:
    ensure  => $_ensure,
    val     => $value,
    require => File['/etc/sysctl.d/20-simp.conf']
  }

  if $value != 'nil' {
    sysctl_set_value { $name:
      val => $value
    }
  }
}
