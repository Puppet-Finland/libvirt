#
# == Class: libvirt::config
#
class libvirt::config
(
    $vnc_listen

) inherits libvirt::params
{
    file { 'libvirt-qemu.conf':
        ensure  => present,
        name    => '/etc/libvirt/qemu.conf',
        content => template('libvirt/qemu.conf.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        require => Class['libvirt::install'],
        notify  => Class['libvirt::service'],
    }
}
