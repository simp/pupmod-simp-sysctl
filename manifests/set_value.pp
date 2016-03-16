# == Define: sysctl::set_value
#
# This has been deprecated, plesae used sysctl::value from now on.
#
define sysctl::set_value(
  $value,
  $apply = true,
  $silent = false
){
  sysctl::value { $name: value => $value, apply => $apply, silent => $silent }

  notice('sysctl::set_value has been deprecated, please change all calls to sysctl::value')
}
