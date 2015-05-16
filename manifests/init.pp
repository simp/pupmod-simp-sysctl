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

    file { '/etc/sysctl.conf':
        ensure => 'present',
        owner  => 'root',
        group  => 'root',
        mode   => '0600',
    }
}
