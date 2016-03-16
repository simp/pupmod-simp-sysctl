# == Define: sysctl::value
#
# This module has been updated to use the augeasproviders_sysctl module.
#
# Please use the `sysctl` native type if possible.
#
# DEPRECATION NOTICE: This module will be deprecated in the next major release of SIMP.
#
# == Parameters
#
# [*value*]
#  Type: String
#  Value to set in sysctl.conf.  Set vaule to 'nil' to remove the
#  variable from the sysctl.conf file.
#
# [*apply*]
#   Type: Boolean
#   If true, apply the value to the running system as well as updating the
#   configuration file.
#
# [*silent*]
#   Type: Boolean
#   If true, do not register a failure if the sysctl value does not exist on
#   the system.
#
# == Author
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define sysctl::value(
  $value,
  $apply = true,
  $silent = false
){
  include 'sysctl'

  validate_string($value)

  $_ensure  = $value ? {
    'nil'   => 'absent',
    default => 'present'
  }

  if ($::operatingsystem in ['RedHat','CentOS']) and ($::operatingsystemmajrelease < '7') {
    $_target = '/etc/sysctl.conf'
  }
  else {
    $_target = '/etc/sysctl.d/20-simp.conf'
  }

  sysctl { $name:
    ensure => $_ensure,
    val    => $value,
    apply  => $apply,
    silent => $silent,
    target => $_target
  }
}
