# == Class: sysctl
#
# sysctl/manifests/init.pp - Define sysctl module stuff
#
# == Parameters
#
# == Author
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class sysctl {

  file { '/etc/sysctl.d/':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  file { '/etc/sysctl.d/20-simp.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600'
  }
}
